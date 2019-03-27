
xpaths <-  list(
  item_id = 'self::td',
  descricao  =  'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../../tr[1]/td',
  descricao_complementar = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/..',
  quantidade  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Quantidade:")]/..',
  valor_estimado  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Valor estimado")]/..',
  unidade_fornecimento  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Unidade de fornecimento:")]/..',
  tratamento_diferenciado  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Tratamento Diferenciado:")]/..',
  decreto_7174  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Decreto 7174:")]/..',
  margem_preferencia  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Margem de Prefer")]/..',
  situacao  = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../../..//td//*[contains(text(),"Situa")]/..',
  resultado = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../ancestor::table[2]/following-sibling::table[1]'
  )
