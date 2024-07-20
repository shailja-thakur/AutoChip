module top_module(
	input a, 
	input b,
	output out
);
    // missing semicolon after closing parenthesis 
    
    assign out = a & b; // Implementing AND gate using bitwise AND operator &
    
endmodule
