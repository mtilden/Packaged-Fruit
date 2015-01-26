PACKAGE BODY fruits IS
-------------------------------------------------------------------
-------------------------------------------------------------------
FUNCTION new_fruit(s: Size_Type; f: Firmness_Type; t: Taste_Type) RETURN Fruit_Type IS
		Fruit_Temp: Fruit_Type;
	BEGIN
		 Fruit_Temp := (s, f, t);
		 return Fruit_Temp;
END new_fruit;
-------------------------------------------------------------------
-------------------------------------------------------------------
FUNCTION get_Size(item: Fruit_Type) RETURN Size_Type IS 
	size : Size_Type;
	BEGIN
		size := item.s;
		return size;
END get_Size;
-------------------------------------------------------------------
-------------------------------------------------------------------
FUNCTION get_Firmness(item: Fruit_Type) RETURN Firmness_Type IS 
		firm : Firmness_Type;
	BEGIN
		firm := item.f;
		return firm;
END get_Firmness;
-------------------------------------------------------------------
-------------------------------------------------------------------
FUNCTION get_Taste(item: Fruit_Type) RETURN Taste_Type IS
		taste : Taste_Type;
	BEGIN
		taste := item.t;
		return taste;
END get_Taste;
-------------------------------------------------------------------
-------------------------------------------------------------------	
		
END fruits;
