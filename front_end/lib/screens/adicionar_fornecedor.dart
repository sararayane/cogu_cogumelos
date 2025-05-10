import 'package:flutter/material.dart';
import 'package:cogu_cogumelo/models/modelo_fornecedores.dart';
import 'package:cogu_cogumelo/services/repositorio.dart';
import 'package:cogu_cogumelo/widgets/app_header_bar.dart';
import 'package:cogu_cogumelo/widgets/app_text_field.dart';
import 'package:cogu_cogumelo/widgets/primary_button.dart';
import '../utils/index.dart';

class AdicionarFornecedor extends StatefulWidget {
  const AdicionarFornecedor({super.key});

  @override
  State<AdicionarFornecedor> createState() => _AdicionarFornecedorState();
}

class _AdicionarFornecedorState extends State<AdicionarFornecedor> {
  final _repo = Repository.instance;
  final _nameCtrl = TextEditingController();
  final _prodCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _prodCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final nome = _nameCtrl.text.trim();
    if (nome.isEmpty) return;

    final fornecedor = Fornecedor(
      id: null,
      name: nome,
      product: _prodCtrl.text.trim(),
      desc: _descCtrl.text.trim(),
    );

    await _repo.addSupplier(fornecedor);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fornecedor salvo com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Responsividade: celular, tablet e desktop
    final double contentMaxWidth;
    final double hPadding;
    final double gapFields;
    if (width <= 600) {
      contentMaxWidth = double.infinity;
      hPadding = 24;
      gapFields = 20;
    } else if (width <= 960) {
      contentMaxWidth = 480;
      hPadding = 32;
      gapFields = 24;
    } else {
      contentMaxWidth = 600;
      hPadding = 40;
      gapFields = 28;
    }

    return Scaffold(
      appBar: AppHeaderBar(onBack: () => Navigator.pop(context)),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    S.addSupplierTitle,
                    style: const TextStyle(
                      color: AppColors.titleBrown,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                AppTextField(controller: _nameCtrl, label: 'nome'),
                SizedBox(height: gapFields),
                AppTextField(controller: _prodCtrl, label: 'produto fornecido'),
                SizedBox(height: gapFields),
                AppTextField(
                  controller: _descCtrl,
                  label: 'descrição',
                  maxLines: 2,
                ),
                SizedBox(height: gapFields + 8),

                Center(
                  child: SizedBox(
                    width: 180,
                    child: PrimaryButton(label: S.confirm, onTap: _save),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
