// The truth table is for a three-input, one-output function. 
//It has 8 rows for each of the 8 possible input combinations, and one output column. 
//There are four inputs combinations where the output is 1, and four where the output is 0.

Row	Inputs	Outputs
number	x3	x2	x1	f
0	0	0	0	0
1	0	0	1	0
2	0	1	0	1
3	0	1	1	1
4	1	0	0	0
5	1	0	1	1
6	1	1	0	0
7	1	1	1	1

//Create a combinational circuit that implements the above truth table.

// Hint: One simple method to create a circuit that implements the truth table's function 
// is to express the function in sum-of-products form. Sum (meaning OR) of products 
// (meaning AND) means using one N-input AND gate per row of the truth table (to detect 
// when the input matches each row), followed by an OR gate that chooses only those 
// rows that result in a '1' output.

// For the above example, the output is '1' if the input matches row 2 or row 3 or row 5 or row 7 
// (This is a 4-input OR gate). The input matches row 2 if x3=0 and x2=1 and x1=0 (This is a 3-input AND gate). 
// Thus, this truth table can be implemented in canonical form by using 4 AND gates that are ORed together.

module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);

	// Insert your code here

endmodule
