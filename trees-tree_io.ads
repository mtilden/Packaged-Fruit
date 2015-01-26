with ada.text_io; USE Ada.Text_IO;
WITH ada.Command_Line; USE ADA.Command_Line;
with Ada.Integer_Text_IO; USE Ada.Integer_Text_IO; 
WITH Ada.Float_Text_IO; USE Ada.Float_Text_IO;
WITH ada.characters.handling; USE  ada.characters.handling;
WITH ada.exceptions; USE ada.exceptions; 


GENERIC
PACKAGE trees.tree_io IS
    -- Output information on a single tree
    PROCEDURE put_ID_Type_and_count(t: Tree_Type);
    PROCEDURE put_ID_Type_and_count_and_Fruits_and_Averages(t: Tree_Type);
    PROCEDURE put_ID_Type_and_count_And_Averages(t: Tree_Type);

    -- Output information on all trees
    PROCEDURE put_all_ID_Type_and_count(tl: Tree_List_Type);
    PROCEDURE put_all_ID_Type_and_count_and_Fruits_and_Averages(tl: Tree_List_Type);
    PROCEDURE put_all_ID_Type_and_count_And_Averages(tl: Tree_List_Type);

    -- Read all tree data from a file
    PROCEDURE get(file: File_Type; list: IN OUT Tree_List_Type);
    PROCEDURE get(list: IN OUT Tree_List_Type);

    -- Skip white space and then read an ID number
    PROCEDURE get(id: OUT ID_Type);
    PROCEDURE get(file: File_Type; id: OUT ID_Type);

    -- Output an ID
    PROCEDURE put(id: ID_Type);
END trees.tree_io;
