module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	
	// Define all the possible input combinations 
	parameter INPUT_0 = 4'b0000; // Represents 0
	parameter INPUT_1 = 4'b0001; // Represents 1
	parameter INPUT_2 = 4'b0010; // Represents 2
	parameter INPUT_3 = 4'b0011; // Represents 3
	parameter INPUT_4 = 4'b0100; // Represents 4
	parameter INPUT_5 = 4'b0101; // Represents 5
	parameter INPUT_6 = 4'b0110; // Represents 6
	parameter INPUT_7 = 4'b0111; // Represents 7
	parameter INPUT_8 = 4'b1000; // Represents 8
	parameter INPUT_9 = 4'b1001; // Represents 9
	parameter INPUT_10 = 4'b1010; // Represents 10
	parameter INPUT_11 = 4'b1011; // Represents 11
	parameter INPUT_12 = 4'b1100; // Represents 12
	parameter INPUT_13 = 4'b1101; // Represents 13
	parameter INPUT_14 = 4'b1110; // Represents 14
	parameter INPUT_15 = 4'b1111; // Represents 15
	
	// Define the output logic
	assign out_sop = (INPUT_15 == {a,b,c,d}) |     // Input 15 = 4'b1111
                     (INPUT_7 == {a,b,c,d})  |     // Input 7 = 4'b0111
                     (INPUT_2 == {a,b,c,d});       // Input 2 = 4'b0010
	
	assign out_pos = ~( (INPUT_0  == {a,b,c,d})  |    // Input 0 = 4'b0000
                        (INPUT_1  == {a,b,c,d})  |    // Input 1 = 4'b0001
                        (INPUT_4  == {a,b,c,d})  |    // Input 4 = 4'b0100
                        (INPUT_5  == {a,b,c,d})  |    // Input 5 = 4'b0101
                        (INPUT_6  == {a,b,c,d})  |    // Input 6 = 4'b0110
                        (INPUT_9  == {a,b,c,d})  |    // Input 9 = 4'b1001
                        (INPUT_10 == {a,b,c,d})  |    // Input 10 = 4'b1010
                        (INPUT_13 == {a,b,c,d})  |    // Input 13 = 4'b1101
                        (INPUT_14 == {a,b,c,d}) );    // Input 14 = 4'b1110
endmodule
