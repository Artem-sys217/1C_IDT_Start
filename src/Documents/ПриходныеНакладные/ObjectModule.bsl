Процедура ОбработкаПроведения(Отказ,Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	//Данный фрагмент построен конструктором.
	//При повторном использовании конструктора, внесенные вручную данные будут утеряны!

	// регистр ОстаткиМатериалов
	Движения.ОстаткиМатериалов.Записывать = Истина;
	Для Каждого ТекСтрокаМатериалы из Материалы Цикл
		Движение = Движения.ОстаткиМатериалов.Добавить();
		Движение.Период = Дата;
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Материал = ТекСтрокаМатериалы.Материал;
		Движение.Склады = Склад;
		Движение.Количество = ТекСтрокаМатериалы.Количество;
	КонецЦикла;

	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры