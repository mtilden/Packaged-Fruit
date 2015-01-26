-- Name: Madison Tilden
-- Date: 12/11/14
-- Course: ITEC 320 Principles of Procedural Programming

-- Purpose: There will be two input streams to the program: 
-- one or more files specified in the command line and then standard input
-- The files specified in the command line will contain information on 
-- trees and samples. Read each of these files until end of file.
-- The input files will contain data on between one and one thousand 
-- trees, inclusive, and on between 0 and 20 samples per tree, also inclusive.
-- The information for each tree will be a sequence of items as follows:
-- The keyword "TREE".
-- A tree identification string of exactly 7 letters or digits.
-- After a tree identification string come a possibly empty sequence of
-- data on fruit samples. Each piece of fruit will be introduced by the
-- keyword "FRUIT", followed by three words to describe the 
-- following characteristics, in this order:
-- Size: small, midsize, large
-- Firmness: soft, firm, hard
-- Taste: bland, sweet, sour
-- A tree with a given ID number can appear more than once in the data.
 
-- Standard input will contain a sequence of commands that will direct
-- the program's output. These commands determine program output and operation, as follows:
--"Trees": Output only Tree id number and number of fruit samples
--"Averages": Output as in Trees, plus the average and standard 
-- deviation of each category for each tree.
--"Fruits": Output as in Trees, plus each fruit and average and standard deviation as in Averages
--"Tree ID": Output only Tree id number and number of fruit samples
--"Average ID": Output as in Trees, plus the average and standard
-- deviation of each category for the specified tree.
--"Fruit ID": Output as in Trees, plus each fruit and average and standard deviation as in Averages
--"Quit": Halt the program


with trees;
with trees.tree_io;
with fruits; use fruits;
WITH Ada.Text_IO; USE Ada.Text_IO;
WITH ada.characters.handling; USE  ada.characters.handling;
WITH ada.Command_Line; USE ADA.Command_Line;
WITH Ada.Float_Text_IO; USE Ada.Float_Text_IO;
WITH Ada.Numerics.Elementary_functions; --USE Ada.Numerics.Generic_Elementary_Functions;
WITH ada.exceptions; USE ada.exceptions; 

PROCEDURE packaged_fruit IS
-------------------------------------------------------------------
-------------------------------------------------------------------
-- uses trees and tree-tree_io passing in 1000 and 20 for max trees and fruits
package mytreespkg is new trees(1000, 20);
USE mytreespkg;
package mytreespkg_IO is new mytreespkg.Tree_IO;
USE mytreespkg_IO;

--list : Tree_List_Type;

-------------------------------------------------------------
-------------------------------------------------------------



-------------------------------------------------------------
-------------------------------------------------------------
-- will read input from the command line 
-- if no file names exist a error will be output to the user
-- will read all files and store information into list of Tree_List_Type

PROCEDURE read_Input( File: IN OUT File_Type; list : IN OUT Tree_List_Type) IS


BEGIN
  IF argument_count = 0 THEN
	RAISE CONSTRAINT_ERROR with "Please enter a file name!";
  ELSE
	FOR l in 1 .. Argument_Count LOOP
	open(file => file, mode => In_File, name => argument(l));		-- opens file one at a time
	get(file, list);												-- procedure in tree-tree_IO
	close (File => file);											-- CLOSE FILE
	END LOOP;
  END IF;
  

END read_Input;

-------------------------------------------------------------
-------------------------------------------------------------
-- After reading from files the user will be able to enter a list of 
-- commands being trees, tree ID, fruits, fruit ID, averages, average ID
-- and quit.. quit being to exit the program
-- if incorrect command name is entered a exception will tell the error 
-- and allow them to continue
PROCEDURE cmd_commands (list : IN Tree_List_Type) IS
    TYPE cmdKeywords IS (trees, fruits, averages, tree, average, fruit, quit);
    PACKAGE cmdKeywords_IO IS NEW Ada.Text_IO.Enumeration_IO(cmdKeywords);
    USE cmdKeywords_IO;
    cmdKey: cmdKeywords;	-- COMMAND KEY

	id : ID_Type;		-- TEMP ID TYPE
	BEGIN
		BEGIN
	  get(cmdKey);
	  WHILE cmdKey /= quit LOOP                -- IF CMD ARGUMENT = QUIT EXIT THE PROGRAM
		--BEGIN
	    IF cmdKey = trees THEN				-- IF THE KEY IS TREES
		  put_all_ID_Type_and_count(list);
		ELSIF cmdKey = fruits THEN			-- THE KEY IS FRUITS
		  put_all_ID_Type_and_count_and_Fruits_and_Averages(list);
		ELSIF cmdKey = averages THEN				-- THE KEY IS AVERAGES
		  put_all_ID_Type_and_count_And_Averages(list);
		ELSIF cmdKey = tree THEN				-- if they key is TREE get an ID then print out id type and count
			get(id);
			put_ID_Type_and_count(Get_Tree(list, id));
		ELSIF cmdKey = average THEN				-- if key is AVERAGE ID
			get(id);
			put_ID_Type_and_count_And_Averages(Get_Tree(list, id));
		ELSIF cmdkey = fruit THEN				-- IF KEY IS FRUIT get the id to go with it
	    	get(id);
		    put_ID_Type_and_count_and_Fruits_and_Averages(Get_Tree(list, id));
		END IF;
		get(cmdKey);				-- GET NEXT COMMAND
		
		
	END LOOP; 
	EXCEPTION
	  	WHEN DATA_ERROR =>
	  			put_line("You did not enter a valid keyword (trees, tree ID, fruits,");
				put_line(" fruit ID, averages, average ID, quit).");
	  			skip_line;
	  			get(cmdKey);
		END;
END cmd_commands;
-------------------------------------------------------------
-------------------------------------------------------------

-------------------------------------------------------------
-------------------------------------------------------------
list : mytreespkg.Tree_List_Type;
file: File_Type;

	BEGIN
	  read_Input(file, list);	-- READ INPUT FROM FILES
	  cmd_commands(list);		-- COMMANDS FROM STANDARD INPUT
-------------------------------------------------------------------
-------------------------------------------------------------------
EXCEPTION 
when Too_Many_Trees => put_line("Too many trees"); 
when Too_Many_Fruits => put_line("Too many Fruits");
END packaged_fruit;
