with ada.text_io; use ada.text_io;
package fruits is
    type Fruit_Type is private;

    type Size_Type is (small, midsize, large);
    type Firmness_Type is (soft, firm,hard);
    type Taste_Type is (bland, sweet, sour);

    package Size_IO is new ada.text_io.enumeration_io(Size_Type);
    package Firmness_IO is new ada.text_io.enumeration_io(Firmness_Type);
    package Taste_IO is new ada.text_io.enumeration_io(Taste_Type);

    function new_fruit(s: Size_Type; f: Firmness_Type; t: Taste_Type) return Fruit_Type;

    function get_Size(item: Fruit_Type) return Size_Type;
    function get_Firmness(item: Fruit_Type) return Firmness_Type;
    function get_Taste(item: Fruit_Type) return Taste_Type;

private

    type Fruit_Type is record
		s: Size_Type;
		f: Firmness_Type;
		t: Taste_Type;
	end record;

end fruits;
