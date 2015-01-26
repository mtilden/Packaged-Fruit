-- Name: Madison Tilden
-- Date: 12/11/14
-- Course: ITEC 320 Principles of Procedural Programming


PACKAGE BODY trees.tree_io IS 		
-------------------------------------------------------------------
-------------------------------------------------------------------
-- CHECKS IF THE ID IS ALREADY IN THE ARRAY

PROCEDURE checkID(list: in out Tree_List_Type; id: in ID_Type) is 

BEGIN
	
	FOR i IN 1 .. list.Tree_Counter LOOP					-- for 1 in number of trees in array
		IF list.Tree_Array(i).id = id THEN					-- if an id matches
			list.Tree_Counter := list.Tree_Counter - 1;		-- decrement tree counter by 1
			list.Tree_Index := i;							-- set the index for the tree is the place in the array
			exit;											-- exit loop
		ELSE
			list.Tree_Index := list.Tree_Counter;			-- if it doesnt match put the id in the next arary location
		END IF;
	END LOOP;
	list.Tree_Array(list.Tree_Index).id := id;			-- SET ID TO CURRENT TREE IN THE ARRAY
	
end checkID;
-------------------------------------------------------------------
-------------------------------------------------------------------
-- gets the averages of a Tree_Type
-- for size firmness and taste will save the values for each in the 
-- tree_Type and then in Size_Avg, Firm_Avg, and Taste_Avg
-- if there are no fruits on tree all 3 will automatically by set to 0.0
PROCEDURE get_Averages(tree1: IN OUT Tree_Type) IS
	tempS, tempF, tempT : Float := 0.0;
	temp2, temp4, temp6 : Float := 0.0;
	BEGIN
		
 	  if tree1.Fruit_Info.Fruit_Counter = 0 then			-- if there are no fruits set all to 0.0
 		  tree1.Size_Avg := 0.0;
		  tree1.Firm_Avg := 0.0;
		  tree1.Taste_Avg := 0.0;
 	  else
	  
 	  for b in 1 .. tree1.Fruit_Info.Fruit_Counter loop 				
 		   if Get_Size(tree1.Fruit_Info.Fruit_Array(b)) = small then			-- if small set temp to 1.0
 			   tempS := 1.0;
 		   elsif Get_Size(tree1.Fruit_Info.Fruit_Array(b)) = midsize then		-- if midsize set temp to 2.0
 			   tempS := 2.0;
 		   elsif Get_Size(tree1.Fruit_Info.Fruit_Array(b)) = large then			-- if large set temp to 3.0
 			   tempS := 3.0;
 		   end if;
 		  temp2 := temp2 + tempS;
 	  end loop;
 	  temp2 := temp2 / float(tree1.Fruit_Info.Fruit_Counter);					-- divide total by number of fruits 
 	  tree1.Size_Avg := Average_Type(temp2);									-- set average temp to actual average var in tree type
	  
 	  for d in 1 .. tree1.Fruit_Info.Fruit_Counter loop
 		   if Get_Firmness(tree1.Fruit_Info.Fruit_Array(d)) = soft then			-- if soft set temp to 1.0
 			   tempF := 1.0;
 		   elsif Get_Firmness(tree1.Fruit_Info.Fruit_Array(d)) = firm then		-- if firm set temp to 2.0
 			   tempF := 2.0;	
 		   elsif Get_Firmness(tree1.Fruit_Info.Fruit_Array(d)) = hard then		-- if hard set temp to 3.0
 			   tempF := 3.0;
 		   end if;
 		  temp4 := temp4 + tempF;
 	  end loop;
 	  temp4 := temp4 / float(tree1.Fruit_Info.Fruit_Counter);
	  tree1.Firm_Avg := Average_Type(temp4);									-- set average temp to actual average var
	  -- in tree type
	  
	  for z in 1 .. tree1.Fruit_Info.Fruit_Counter loop
		   if Get_Taste(tree1.Fruit_Info.Fruit_Array(z)) = bland then			-- if bland set temp to 1.0
			   tempT := 1.0;
		   elsif Get_Taste(tree1.Fruit_Info.Fruit_Array(z)) = sweet then		-- if sweet set temp to 2.0
			   tempT := 2.0;
		   elsif Get_Taste(tree1.Fruit_Info.Fruit_Array(z)) = sour then			-- if sour set temp to 3.0
			   tempT := 3.0;
		   end if;
		   temp6 := temp6 + tempT;
	  end loop;

  	temp6 := temp6 / float(tree1.Fruit_Info.Fruit_Counter);
	tree1.Taste_Avg := Average_Type(temp6);							-- set average temp to actual average var in tree type

    end if;
	
END get_Averages;
-------------------------------------------------------------
-------------------------------------------------------------
-- gets the standard deviation for each tree and sets it equal to 
-- the values inside Size_Dev, Firm_Dev, Taste_Dev
-- if there are no fruits on a tree these 3 variables will be set to 0.0
PROCEDURE get_Standard_Dev (tree1: IN OUT Tree_Type) IS
	tempSize, tempFirm, tempTaste : Float := 0.0;
	temp, temp1, temp2, temp3, temp4, temp5 : Float := 0.0;
	BEGIN
       IF tree1.Fruit_Info.Fruit_Counter = 0 then
     		  tree1.Size_Dev := 0.0;
			  tree1.Firm_Dev := 0.0;
			  tree1.Taste_Dev := 0.0;
       ELSE
 		  for d in 1 .. tree1.Fruit_Info.Fruit_Counter loop
 		     if Get_Size(tree1.Fruit_Info.Fruit_Array(d)) = small then
 		  			   temp1 := 1.0;
 		     elsif Get_Size(tree1.Fruit_Info.Fruit_Array(d)) = midsize then
 		  			   temp1 := 2.0;
 		     elsif Get_Size(tree1.Fruit_Info.Fruit_Array(d)) = large then
 		  			   temp1 := 3.0;
 		  	  end if;
 			  tempSize := temp1 - tree1.Size_Avg; -- VALUE MINUS AVG
 			  tempSize := tempSize * tempSize;		-- SQUARE THAT NUMBER
 			  temp := temp + tempSize;	-- ADD ALL THOSE NUMBERS UP FOR EACH FRUIT
 			
 		  end loop;
 		  temp := temp / Float(tree1.Fruit_Info.Fruit_Counter);			-- temp divided by fruit counter
 		  temp := Ada.Numerics.Elementary_functions.Sqrt(temp);			-- sqrt temp
		  tree1.Size_Dev := Standard_Deviation_Type(temp);				-- sets dev to temp value 
		  
		  
		  for g in 1 .. tree1.Fruit_Info.Fruit_Counter loop
		     if Get_Firmness(tree1.Fruit_Info.Fruit_Array(g)) = soft then
			  			   temp2 := 1.0;
		     elsif Get_Firmness(tree1.Fruit_Info.Fruit_Array(g)) = firm then
			  			   temp2 := 2.0;
			 elsif Get_Firmness(tree1.Fruit_Info.Fruit_Array(g)) = hard then
			  			   temp2 := 3.0;
			end if;
			tempFirm := temp2 - tree1.Firm_Avg; -- VALUE MINUS AVG
		    tempFirm := tempFirm * tempFirm;		-- SQUARE THAT NUMBER
			temp4 := temp4 + tempFirm;	-- ADD ALL THOSE NUMBERS UP FOR EACH FRUIT
		end loop;
		temp4 := temp4 / Float(tree1.Fruit_Info.Fruit_Counter);			-- temp divided by fruit counter
		temp4 := Ada.Numerics.Elementary_functions.Sqrt(temp4);			-- sqrt the temp variable
		tree1.Firm_Dev := Standard_Deviation_Type(temp4);				-- sets the dev to temp value
		
	  for n in 1 .. tree1.Fruit_Info.Fruit_Counter loop
	     if Get_Taste(tree1.Fruit_Info.Fruit_Array(n)) = bland then
	  			   temp3 := 1.0;
	     elsif Get_Taste(tree1.Fruit_Info.Fruit_Array(n)) = sweet then
	  			   temp3 := 2.0;
	     elsif Get_Taste(tree1.Fruit_Info.Fruit_Array(n)) = sour then
	  			   temp3 := 3.0;
	  	  end if;
		tempTaste := temp3 - tree1.Taste_Avg; -- VALUE MINUS AVG
	    tempTaste := tempTaste * tempTaste;		-- SQUARE THAT NUMBER
		temp5 := temp5 + tempTaste;	-- ADD ALL THOSE NUMBERS UP FOR EACH FRUIT
	end loop;
	temp5 := temp5 / Float(tree1.Fruit_Info.Fruit_Counter);				-- temp divided by fruit counter
	temp5 := Ada.Numerics.Elementary_functions.Sqrt(temp5);				-- sqrt the temp variable
		
	tree1.Taste_Dev := Standard_Deviation_Type(temp5);					-- sets the dev to temp value
		
 	END IF;	
	
 	
END get_Standard_Dev;
-------------------------------------------------------------
-------------------------------------------------------------




-- tree ID command
-- Output information on a single tree (id and number of fruits)
PROCEDURE put_ID_Type_and_count(t: Tree_Type) IS 

	BEGIN 
	ada.Text_io.put("TREE: ");
	put(get_ID(t));									-- put id number
	ada.Text_IO.put("   ");
	put(Integer(get_Fruit_Count(t))'img);			-- number of fruits
	ada.Text_IO.new_line;
END put_ID_Type_and_count;

-------------------------------------------------------------------
-------------------------------------------------------------------
-- fruit ID command
--PRINTS OUT THE ID NUMBER OF EACH TREE ALONG WITH THE NUMBER 
-- OF FRUITS AND THE AVERAGES/ STANDARD DEVIATION
PROCEDURE put_ID_Type_and_count_and_Fruits_and_Averages(t: Tree_Type) IS
	BEGIN 
	ada.text_io.put("TREE: ");
	put(get_ID(t));
	ada.Text_IO.put("   ");
	put(get_Fruit_Count(t)'img);				-- number of fruits
	ada.Text_IO.new_line;
	-- PRINTS OUT FRUIT INFO BELOW
	for g in 1 .. t.Fruit_Info.Fruit_Counter loop
		ada.text_IO.set_col(5);
		Size_IO.put(get_Size(t.Fruit_Info.Fruit_Array(g)));					-- PRINT SIZE
		ada.text_IO.set_col(13);
		Firmness_IO.put(get_Firmness(t.Fruit_Info.Fruit_Array(g)));			-- PRINT FIRM
		ada.text_IO.set_col(21);
		Taste_IO.put(get_Taste(t.Fruit_Info.Fruit_Array(g)));				-- PRINT TASTE
		ada.text_IO.new_line;
	END LOOP;
	--PRINTS OUT AVERAGES FOR TREE
	ada.text_IO.set_col(5);
	put(get_Size_Average(t), fore => 1, aft => 1, exp => 0);				-- print Size_Avg
	ada.text_IO.set_col(13);
	put(get_Firmness_Average(t), fore => 1, aft => 1, exp => 0);			-- print Firm_Avg
	ada.text_IO.set_col(21);	
	put(get_Taste_Average(t), fore => 1, aft => 1, exp => 0);				-- print Taste_Avg
	ada.text_IO.new_line;
	--PRINTS OUT DEVIATION
	ada.text_IO.set_col(5);
	put(get_Size_Standard_Deviation(t), fore => 1, aft => 1, exp => 0);			-- print Size_Dev
	ada.text_IO.set_col(13);
	put(get_Firmness_Standard_Deviation(t), fore => 1, aft => 1, exp => 0);		
	ada.text_IO.set_col(21);
	put(get_Taste_Standard_Deviation(t), fore => 1, aft => 1, exp => 0);
	new_line;
END put_ID_Type_and_count_and_Fruits_and_Averages;

-------------------------------------------------------------------
-------------------------------------------------------------------
-- AVERAGE ID command
-- PRINTS OUT ID, NUMBER OF FRUITS, AVERAGES AND 
-- STANDARD DEVIATION OF A SINGLE TREE
PROCEDURE put_ID_Type_and_count_And_Averages(t: Tree_Type) IS
	--s_avg, f_avg, t_avg : Average_Type;
	--s_dev, f_dev, t_dev : Standard_Deviation_Type;
	BEGIN
		ada.text_io.put("TREE: ");
		put(get_ID(t));					-- prints out ID
		ada.Text_IO.put("   ");
		put(get_Fruit_Count(t)'img);	--prints out number of fruits
		ada.Text_IO.new_line;
		--prints out averages
		ada.text_IO.set_col(5);
		put(get_Size_Average(t), fore => 1, aft => 1, exp => 0);
		ada.text_IO.set_col(13);
		put(get_Firmness_Average(t), fore => 1, aft => 1, exp => 0);
		ada.text_IO.set_col(21);
		put(get_Taste_Average(t), fore => 1, aft => 1, exp => 0);
		ada.text_IO.new_line;
		-- prints out deviation
		ada.text_IO.set_col(5);
		put(get_Size_Standard_Deviation(t), fore => 1, aft => 1, exp => 0);
		ada.text_IO.set_col(13);
		put(get_Firmness_Standard_Deviation(t), fore => 1, aft => 1, exp => 0);
		ada.text_IO.set_col(21);
		put(get_Taste_Standard_Deviation(t), fore => 1, aft => 1, exp => 0);
		new_line;
END put_ID_Type_and_count_And_Averages;

-------------------------------------------------------------------
-------------------------------------------------------------------

-- Output information on all trees
-- ID AND NUMBER OF FRUITS ON EACH TREE
PROCEDURE put_all_ID_Type_and_count(tl: Tree_List_Type) IS
	--tree: Tree_Type;
	BEGIN
		FOR b IN 1 .. tl.Tree_Counter LOOP
 		  
		  ada.text_IO.put("TREE: ");
 		  put(get_id(tl.Tree_Array(b)));				-- PRINT TREE ID 
 		  ada.text_IO.put(" ");
 		  put(get_Fruit_Count(tl.Tree_Array(b)));	-- PRINT NUMBER OF FRUITS
 		  ada.text_IO.new_line;
		END LOOP;
END put_all_ID_Type_and_count;

-------------------------------------------------------------------
-------------------------------------------------------------------
-- FRUITS COMMAND
-- PRINTS OUT EVERYTHING .. ID, NUM OF FRUITS WHAT THE FRUITS ARE,
-- AVERAGES, AND STANDARD DEVIATION OF EVERY TREE
PROCEDURE put_all_ID_Type_and_count_and_Fruits_and_Averages(tl: Tree_List_Type) IS
	tree1 : Tree_Type;
	r : Tree_Index_type;
	BEGIN
		for z in 1 .. tl.Tree_Counter loop
		 r := tree_Index_Type(z);
		 tree1:= get_Tree(tl, r);
		 ada.text_IO.put("TREE: ");
		 put(get_ID(tl.Tree_Array(z)));		-- PRINT OUT TREE ID FOR EACH TREE
		 ada.text_IO.put(" ");
		 put(get_Fruit_Count(tl.Tree_Array(z)));-- PRINT OUT NUMBER OF FRUITS FOR EACH
		 ada.text_IO.put(":");
		 ada.text_IO.new_line;
		  for f in 1 .. tl.Tree_Array(z).Fruit_Info.Fruit_Counter loop-- THROUGH NUMBER OF FRUITS FOR EACH TREE
			ada.text_IO.set_col(5);
			Size_IO.put(get_size(tl.Tree_Array(z).Fruit_Info.Fruit_Array(f)));		-- PRINT SIZE
			ada.text_IO.set_col(13);
			Firmness_IO.put(get_firmness(tl.Tree_Array(z).Fruit_Info.Fruit_Array(f)));		-- PRINT FIRM
			ada.text_IO.set_col(21);
			Taste_IO.put(get_taste(tl.Tree_Array(z).Fruit_Info.Fruit_Array(f)));		-- PRINT TASTE
			ada.text_IO.new_line;
			end loop;
			--prints out averages
			ada.text_IO.set_col(5);
			put(tl.Tree_Array(z).Size_Avg, fore=>1, aft=>1, exp=>0);
			ada.text_IO.set_col(13);
			put(tl.Tree_Array(z).Firm_Avg, fore=>1, aft=>1, exp=>0);
			ada.text_IO.set_col(21);
			put(tl.Tree_Array(z).Taste_Avg, fore=>1, aft=>1, exp=>0);
			ada.text_IO.new_line;
			-- prints out deviation
			ada.text_IO.set_col(5);
			put(tl.Tree_Array(z).Size_Dev, fore=>1, aft=>1, exp=>0);
			ada.text_IO.set_col(13);
			put(tl.Tree_Array(z).Firm_Dev, fore=>1, aft=>1, exp=>0);
			
			ada.text_IO.set_col(21);
			put(tl.Tree_Array(z).Taste_Dev, fore=>1, aft=>1, exp=>0);
			new_line;
		end loop;
END put_all_ID_Type_and_count_and_Fruits_and_Averages;

-------------------------------------------------------------------
-------------------------------------------------------------------
-- Prints out all the ID's and number of fruits and their averages and standard deviation
-- of all trees but doesnt print out the fruits
PROCEDURE put_all_ID_Type_and_count_And_Averages(tl: Tree_List_Type) IS

	BEGIN
 	  FOR g in 1 .. tl.Tree_Counter LOOP   
		 --tree1:= get_Tree(tl, g);
		 ada.text_IO.put("TREE: ");
		 put(get_ID(tl.Tree_Array(g)));		-- PRINT OUT TREE ID FOR EACH TREE
		 ada.text_IO.put(" ");
	 	 put(get_Fruit_Count(tl.Tree_Array(g)));-- PRINT OUT NUMBER OF FRUITS FOR EACH
	 	 ada.text_IO.put(":");
		 ada.text_IO.new_line;
		
		 -- PRINTS OUT averages and standard deviation

		--prints out averages
		ada.text_IO.set_col(5);
		put(get_Size_Average(tl.Tree_Array(g)), fore => 1, aft => 1, exp => 0);
		ada.text_IO.set_col(13);
		put(get_Firmness_Average(tl.Tree_Array(g)), fore => 1, aft => 1, exp => 0);
		ada.text_IO.set_col(21);
		put(get_Taste_Average(tl.Tree_Array(g)), fore => 1, aft => 1, exp => 0);
		ada.text_IO.new_line;
		-- prints out deviation
		ada.text_IO.set_col(5);
		put(get_Size_Standard_Deviation(tl.Tree_Array(g)), fore => 1, aft => 1, exp => 0);
		ada.text_IO.set_col(13);
		put(get_Firmness_Standard_Deviation(tl.Tree_Array(g)), fore => 1, aft => 1, exp => 0);
		ada.text_IO.set_col(21);
		put(get_Taste_Standard_Deviation(tl.Tree_Array(g)), fore => 1, aft => 1, exp => 0);
		new_line;
 	  end loop;	
END put_all_ID_Type_and_count_And_Averages;

-------------------------------------------------------------------
-------------------------------------------------------------------

-- Read all tree data from a file
-- and saves all the info into list of TREE_LIST_TYPE
-- if key = tree check if ID is already in the tree or not
-- if key = fruit get the size firmness and taste and
-- create a new fruit using FRUITS.get_fruit_information
PROCEDURE get(file: in File_Type; list: IN OUT Tree_List_Type) IS
	
	type keyword is (tree, fruit);
	package Key_IO is new Ada.Text_IO.Enumeration_IO(keyword);
	use Key_IO;
	key: keyword;
	-------------------------------------------------------------------
	-------------------------------------------------------------------
	-- GETS THE KEY WORD FROM FILE TREE OR FRUIT
	procedure getKey(file: in File_Type; key: in out keyword) is 
	BEGIN
	  get(file, key);
	END getKey;
	-------------------------------------------------------------------
	-------------------------------------------------------------------
	-- GETS A NEW FRUIT
	-- Saves the values to the next spot in the fruit list inside the Tree_Type
	PROCEDURE get_Fruit_Information(file: File_Type; Fruit_list: IN OUT Fruit_List_Type) IS
		S: fruits.Size_Type;
		F: fruits.Firmness_Type;
		T: fruits.Taste_Type;
		USE Size_IO;
		USE Firmness_IO;
		USE Taste_IO;


		BEGIN 
		Size_IO.Get(file, S);			-- get size
		Firmness_IO.Get(file, F);		-- get firmness
		Taste_IO.Get(file, T);			-- get taste
		
		if Fruit_List.Fruit_Counter = trees.Max_Fruit_Count then		-- if too many fruits
			raise Too_Many_Fruits;							-- will raise too many fruits error
		end if;
		Fruit_List.Fruit_Array(Fruit_List.Fruit_Counter) := fruits.new_fruit(S, F, T);	-- creates a new fruit 
		-- in correct loation
	END get_Fruit_Information;
	-------------------------------------------------------------------
	-------------------------------------------------------------------
	
BEGIN 

	LOOP
 	 EXIT WHEN ada.Text_IO.end_of_file (file);			-- EXIT WHEN END OF FILE	
		get(file, key);			-- GET KEY FROM FILE -------------
		IF (key /= tree AND key /= fruit) THEN
			ada.Text_IO.put("You did not enter something correctly");
			--raise DATA_ERROR with "There is a invalid key in the input file";
		END if;
		
   	IF key = tree THEN  			-- IF KEY = TREE THEN GET THE ID NUMBER FOR IT
 				list.Tree_Counter := list.Tree_Counter + 1;	-- INCREMENT NUMBER OF TREES BY 1
	  	  		get(file, list.temp_ID);		-- GET ID PROCEDURE
				checkID(list, list.temp_ID);						-- CHECK IF THE ID ALREADY EXISTS
   	ELSIF key = fruit THEN			-- ELSE IF KEY = FRUIT THEN ..
		---------- I STILL NEED TO THROW AN EXCEPTION IF FRUIT IS THE FIRST KEYWORD NOT TREE
			IF list.Tree_Counter = 0 THEN	-- CHECK IF THERE IS ATLEAST ONE TREE
				raise DATA_ERROR with "You need to have a tree first";		-- RAISE ERROR IF NOT
				ELSIF list.Tree_Counter = trees.Max_Tree_Count THEN
					raise Too_Many_Trees;
			END if;						-- END CHECK FOR TREES IF
	        list.Tree_Array(list.Tree_Index).Fruit_Info.Fruit_Counter := list.Tree_Array(list.Tree_Index).Fruit_Info.Fruit_Counter + 1;
	  	  	get_Fruit_Information(file, list.Tree_Array(list.Tree_Index).Fruit_Info);
		END if;
	END LOOP;
   			-- CLOSE FILE
				
	FOR t in 1 .. list.Tree_Counter LOOP	-- at end of file will get averages and standard deviation values of each tree
	 	  get_Averages(list.Tree_Array(t));
		  get_Standard_Dev(list.Tree_Array(t));
	END LOOP;								-- END LOOP TO GET AVERAGES AND STANDARD DEVIATION
END get;	-- END GET TO READ ALL TREE DATA FROM A FILE 

-------------------------------------------------------------------
-------------------------------------------------------------------
-- gets information from standard input instead of a file name
-- calls the previous get method passing in standard input as a file
PROCEDURE get(list: IN OUT Tree_List_Type) IS 
	BEGIN 
		get(standard_input, list);
END get;

-------------------------------------------------------------------
-------------------------------------------------------------------
-- Skip white space and then read an ID number from standard input
-- sets the ID to upper case so all ID numbers will be the same
PROCEDURE get(id: OUT ID_Type) IS
		c : character;
		EOL, gotid: Boolean;
		temp: String(1 .. 7);
	BEGIN
		ada.Text_IO.look_ahead(c, eol);			-- look ahead
		gotid := false;
		WHILE gotid = false LOOP		-- while GOT ID IS FALSE
		IF eol THEN						-- WHILE LAST CHAR ON LINE IS ' ' THEN SKIP LINE
			skip_line;					-- skips line
			gotid := false;				-- still set gotid to false
		ELSIF c = ' ' THEN				-- if c is ' ' then get the space
			get(c);
			gotid := false;				-- still set gotID to falue
		ELSE 
			ada.Text_IO.get(temp);			-- GET'S THE ID AFTER WHITE SPACES FROM INPUT
			temp := (To_Upper(temp));
			id := ID_Type(temp);		-- ID = temp ID 
			gotid := true;				-- GOT ID IS TRUE TO BREAK OUT OF WHILE LOOP
		END IF;	
		ada.Text_IO.look_ahead(c, eol);							-- END WHILE LOOP
		END LOOP;
END get;

-------------------------------------------------------------------
-------------------------------------------------------------------
-- Skip white space and then read an ID number from a file
-- sets the ID to upper case so all ID numbers will be the same
PROCEDURE get(file: File_Type; id: OUT ID_Type) IS
		c : character;
		EOL, gotid: Boolean;
		temp: String(1 .. 7);
	BEGIN
		ada.Text_IO.look_ahead(file, c, eol);
		gotid := false;
		WHILE gotid = false LOOP
			
		  IF eol THEN						-- WHILE LAST CHAR ON LINE IS ' ' THEN SKIP LINE
			skip_line(file);
			gotid := false;
		  ELSIF c = ' ' THEN				-- if C IS A ' ' get C
			get(file, c);
			gotid := false;
		  ELSE 
			ada.Text_IO.get(file, temp);			-- GET'S THE ID AFTER WHITE SPACES FROM INPUT
			temp := (To_Upper(temp));				-- SETS THE TEMP TO UPPER
			id := ID_Type(temp);					-- SETS ID TO temp
			gotid := true;							-- GOTID = TRUE
		  END IF;	
			ada.Text_IO.look_ahead(file, c, eol);							-- END WHILE LOOP
		END LOOP;
END GET;

-------------------------------------------------------------------
-------------------------------------------------------------------
-- Output an ID as a string
PROCEDURE put(id: ID_Type) IS 

	BEGIN
		ada.Text_IO.put(String(id));
END put;

-------------------------------------------------------------------
-------------------------------------------------------------------
END trees.tree_io;
