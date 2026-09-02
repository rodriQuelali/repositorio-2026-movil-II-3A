import 'dart:io';
import 'package:examplo_mvvm/models/pedido_model.dart';
import 'package:examplo_mvvm/ui/viewmodel/pedido_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class PedidoFormView extends StatefulWidget {
  final PedidoModel? pedido; // null = nuevo pedido, no null = editando

  const PedidoFormView({super.key, this.pedido});

  @override
  State<PedidoFormView> createState() => _PedidoFormViewState();
}

class _PedidoFormViewState extends State<PedidoFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _clienteController;
  late TextEditingController _productoController;
  late TextEditingController _cantidadController;
  late TextEditingController _precioController;
  late TextEditingController _descripcionController;
  DateTime _fechaPedido = DateTime.now();
  EstadoPedido _estado = EstadoPedido.pendiente;

  bool get isEditing => widget.pedido != null;

  @override
  void initState() {
    super.initState();
    final p = widget.pedido;
    _clienteController = TextEditingController(text: p?.cliente ?? '');
    _productoController = TextEditingController(text: p?.producto ?? '');
    _cantidadController = TextEditingController(text: p?.cantidad.toString() ?? '1');
    _precioController = TextEditingController(text: p?.precio.toString() ?? '');
    _descripcionController = TextEditingController(text: p?.descripcion ?? '');
    _fechaPedido = p?.fechaPedido ?? DateTime.now();
    _estado = p?.estado ?? EstadoPedido.pendiente;

    // Precarga la foto y la ubicación existentes (si se está editando) en el ViewModel
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PedidoViewModel>().cargarFotoExistente(p?.fotoPath);
      context.read<PedidoViewModel>().cargarUbicacionExistente(p?.latitud, p?.longitud);
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fechaPedido,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _fechaPedido = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final viewModel = context.read<PedidoViewModel>();
    final pedido = PedidoModel(
      id: widget.pedido?.id,
      cliente: _clienteController.text,
      producto: _productoController.text,
      cantidad: int.parse(_cantidadController.text),
      precio: double.parse(_precioController.text),
      descripcion: _descripcionController.text,
      fechaPedido: _fechaPedido,
      estado: _estado,
      // latitud/longitud se anexan dentro de addPedido/editPedido
      // tomándolas de latitudTemporal/longitudTemporal del ViewModel.
    );

    final success = isEditing
        ? await viewModel.editPedido(pedido)
        : await viewModel.addPedido(pedido);

    if (success && mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PedidoViewModel>();
    final fechaTexto = DateFormat('dd/MM/yyyy').format(_fechaPedido);

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Editar pedido' : 'Nuevo pedido')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ── Sección de foto ──
              Center(
                child: GestureDetector(
                  onTap: () => context.read<PedidoViewModel>().tomarFoto(),
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: viewModel.fotoTemporal != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(viewModel.fotoTemporal!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, size: 36, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Tomar foto', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                  ),
                ),
              ),
              if (viewModel.fotoTemporal != null)
                Center(
                  child: TextButton.icon(
                    onPressed: () => context.read<PedidoViewModel>().limpiarFotoTemporal(),
                    icon: const Icon(Icons.close, size: 18),
                    label: const Text('Quitar foto'),
                  ),
                ),
              const SizedBox(height: 16),

              // ── Sección de ubicación (GPS) ──
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.redAccent),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text('Ubicación del pedido',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        viewModel.obteniendoUbicacion
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : TextButton.icon(
                                onPressed: () =>
                                    context.read<PedidoViewModel>().capturarUbicacion(),
                                icon: const Icon(Icons.my_location, size: 18),
                                label: const Text('Capturar'),
                              ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (viewModel.latitudTemporal != null &&
                        viewModel.longitudTemporal != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Lat: ${viewModel.latitudTemporal!.toStringAsFixed(6)}\n'
                              'Lng: ${viewModel.longitudTemporal!.toStringAsFixed(6)}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                context.read<PedidoViewModel>().limpiarUbicacionTemporal(),
                            child: const Text('Quitar'),
                          ),
                        ],
                      )
                    else
                      const Text(
                        'Sin ubicación capturada aún',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Datos del pedido ──
              TextFormField(
                controller: _clienteController,
                decoration: const InputDecoration(labelText: 'Cliente'),
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _productoController,
                decoration: const InputDecoration(labelText: 'Producto'),
                validator: (v) => (v == null || v.isEmpty) ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cantidadController,
                      decoration: const InputDecoration(labelText: 'Cantidad'),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Requerido';
                        if (int.tryParse(v) == null) return 'Debe ser un número';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _precioController,
                      decoration: const InputDecoration(labelText: 'Precio unitario'),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Requerido';
                        if (double.tryParse(v) == null) return 'Debe ser un número';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción (opcional)'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Fecha del pedido: $fechaTexto'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<EstadoPedido>(
                value: _estado,
                decoration: const InputDecoration(labelText: 'Estado'),
                items: EstadoPedido.values
                    .map((e) => DropdownMenuItem(value: e, child: Text(e.label)))
                    .toList(),
                onChanged: (value) => setState(() => _estado = value!),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? 'Actualizar pedido' : 'Registrar pedido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}