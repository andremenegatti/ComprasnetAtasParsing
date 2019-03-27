xpaths <- list(
  descricao  =  'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../../tr[1]/td', 
  descricao_complementar = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/..',
  quantidade  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Quantidade:")]/..', 
  valor_estimado  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Valor estimado")]/..', 
  unidade_fornecimento  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Unidade de fornecimento:")]/..',
  tratamento_diferenciado  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Tratamento Diferenciado:")]/..', 
  decreto_7174  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Decreto 7174:")]/..', 
  margem_preferencia  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Margem de Prefer")]/..', 
  situacao  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Situa")]/..'
)

char_remove <- list(
  descricao = 'Descri.{2,4}o: ',
  descricao_complementar = 'Descri.{2,4}o Complementar: ',
  quantidade = 'Quantidade: ',
  valor_estimado =  'Valor estimado: .{2} ',
  unidade_fornecimento = 'Unidade de fornecimento: ',
  tratamento_diferenciado = 'Tratamento Diferenciado: |\\r|\\n|\\t',
  decreto_7174 = 'Aplicabilidade Decreto 7174: |\\r|\\n',
  margem_preferencia = 'Aplicabilidade Margem de Prefer.*a: |\\r\\n',
  situacao = 'Situa.{2,4}o: |\\r|\\n|\\t'
)