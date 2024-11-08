Процедура ОбработкаПроведения(Отказ,Режим)

	Движения.ОстаткиМатериалов.Записывать = Истина;
	Движения.СтоимостьМатериалов.Записывать = Истина;
	Движения.Продажи.Записывать = Истина;
	
	
Запрос = Новый Запрос;
Запрос.Текст =
	"ВЫБРАТЬ
	|	ОказаниеУслугиПереченьНоменклатуры.Номенклатура,
	|	ОказаниеУслугиПереченьНоменклатуры.Номенклатура.ВидНоменклатуры КАК ВидНоменклатуры,
	|	СУММА(ОказаниеУслугиПереченьНоменклатуры.Количество) КАК КоличествоВДокументе,
	|	МАКСИМУМ(ОказаниеУслугиПереченьНоменклатуры.Стоимость) КАК Стоимость,
	|	СУММА(ОказаниеУслугиПереченьНоменклатуры.Сумма) КАК СуммаВДокументе
	|ИЗ
	|	Документ.ОказаниеУслуги.ПереченьНоменклатуры КАК ОказаниеУслугиПереченьНоменклатуры
	|ГДЕ
	|	ОказаниеУслугиПереченьНоменклатуры.Ссылка = &Ссылка
	|СГРУППИРОВАТЬ ПО
	|	ОказаниеУслугиПереченьНоменклатуры.Номенклатура,
	|	ОказаниеУслугиПереченьНоменклатуры.Номенклатура.ВидНоменклатуры";

Запрос.УстановитьПараметр("Ссылка", Ссылка);

РезультатЗапроса = Запрос.Выполнить();

ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();

Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	Если ВыборкаДетальныеЗаписи.ВидНоменклатуры = 
	Перечисления.ВидыНоменклатуры.Материал Тогда
	
		Движение = Движения.ОстаткиМатериалов.Добавить();
		Движение.Период = Дата;
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Материал = ВыборкаДетальныеЗаписи.Номенклатура;
		Движение.Склады = Склад;
		Движение.Количество = ВыборкаДетальныеЗаписи.КоличествоВДокументе;
		
		// Регистр СтоимостьМатериалов — Расход

		Движение = Движения.СтоимостьМатериалов.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.Материал = ВыборкаДетальныеЗаписи.Номенклатура;
		Движение.Стоимость = ВыборкаДетальныеЗаписи.КоличествоВДокументе
		* ВыборкаДетальныеЗаписи.Стоимость;
			
	КонецЕсли;
		
		// Регистр Продажи
		Движение = Движения.Продажи.Добавить();
		Движение.Период = Дата;
		Движение.Номенклатура = ВыборкаДетальныеЗаписи.Номенклатура;
		Движение.Клиент = Клиент;
		Движение.Мастер = Мастер;
		Движение.Количество = ВыборкаДетальныеЗаписи.КоличествоВДокументе;
		Движение.Выручка = ВыборкаДетальныеЗаписи.СуммаВДокументе;
		Движение.Стоимость = ВыборкаДетальныеЗаписи.КоличествоВДокументе * ВыборкаДетальныеЗаписи.Стоимость;
		
	
	КонецЦикла;


КонецПроцедуры