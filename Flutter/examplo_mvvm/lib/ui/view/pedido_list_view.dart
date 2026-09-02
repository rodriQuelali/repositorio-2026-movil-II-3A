import 'dart:io';
import 'package:examplo_mvvm/models/pedido_model.dart';
import 'package:examplo_mvvm/ui/viewmodel/pedido_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'pedido_form_view.dart';

class PedidoListView extends StatelessWidget {
  const PedidoListView({super.key});

  Color _colorEstado(EstadoPedido estado) {
    switch (estado) {
      case EstadoPedido.pendiente:
        return Colors.orange;
      case EstadoPedido.enProceso:
        return Colors.blue;
      case EstadoPedido.entregado:
        return Colors.green;
    }
  }

  /// Abre la ubicación del pedido en la app de mapas del dispositivo.
  Future<void> _abrirEnMapa(BuildContext context, double lat, double lng) async {
    final geoUri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');
    final webUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    if (await canLaunchUrl(geoUri) &&
        await launchUrl(geoUri, mode: LaunchMode.externalApplication)) {
      return;
    }

    if (await canLaunchUrl(webUri) &&
        await launchUrl(webUri, mode: LaunchMode.externalApplication)) {
      return;
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El emulador no tiene una app para abrir mapas.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PedidoViewModel>();
    final formatoMoneda = NumberFormat.currency(locale: 'es_BO', symbol: 'Bs. ');

    return Scaffold(
      appBar: AppBar(title: const Text('Pedidos registrados')),
      body: Builder(
        builder: (_) {
          if (viewModel.state == ViewState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.state == ViewState.error) {
            return Center(child: Text(viewModel.errorMessage ?? 'Error'));
          }
          if (viewModel.pedidos.isEmpty) {
            return const Center(child: Text('Aún no hay pedidos registrados'));
          }
          return RefreshIndicator(
            onRefresh: () => context.read<PedidoViewModel>().fetchPedidos(),
            child: ListView.builder(
              itemCount: viewModel.pedidos.length,
              itemBuilder: (context, index) {
                final pedido = viewModel.pedidos[index];
                final fecha = DateFormat('dd/MM/yyyy').format(pedido.fechaPedido);

                return ListTile(
                  leading: pedido.fotoPath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.file(
                            File(pedido.fotoPath!),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const CircleAvatar(child: Icon(Icons.shopping_bag)),
                  title: Text('${pedido.producto} · ${pedido.cliente}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${formatoMoneda.format(pedido.total)} · $fecha · ${pedido.estado.label}',
                      ),
                      if (pedido.tieneUbicacion)
                        Text(
                          'Lat: ${pedido.latitud!.toStringAsFixed(5)}, '
                          'Lng: ${pedido.longitud!.toStringAsFixed(5)}',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                    ],
                  ),
                  isThreeLine: pedido.tieneUbicacion,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PedidoFormView(pedido: pedido)),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (pedido.tieneUbicacion)
                        IconButton(
                          icon: const Icon(Icons.location_on, color: Colors.blue),
                          tooltip: 'Ver ubicación en el mapa',
                          onPressed: () => _abrirEnMapa(
                            context,
                            pedido.latitud!,
                            pedido.longitud!,
                          ),
                        ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => context
                            .read<PedidoViewModel>()
                            .removePedido(pedido.id!, pedido.fotoPath),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab_pedidos',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PedidoFormView()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}