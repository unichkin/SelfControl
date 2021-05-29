#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;		
	КонецЕсли; 
	
	Если НЕ ЗначениеЗаполнено(ЭтотОбъект.Наименование) Тогда
		Если ЗначениеЗаполнено(ЭтотОбъект.ГруппаВопросов) Тогда
			ЭтотОбъект.Наименование = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
				ЭтотОбъект.ГруппаВопросов, "Наименование");			
		КонецЕсли; 		
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти 

#КонецЕсли
