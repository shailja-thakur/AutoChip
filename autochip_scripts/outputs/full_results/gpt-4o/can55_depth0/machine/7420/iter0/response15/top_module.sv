module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

    wire p1_and_result, p2_and_result;
    
    // AND operation for p1 inputs
    assign p1_and_result = p1a & p1b & p1c & p1d;
    
    // AND operation for p2 inputs
    assign p2_and_result = p2a & p2b & p2c & p2d;
    
    // Invert outputs
    assign p1y = ~p1_and_result;
    assign p2y = ~p2_and_result;
    
endmodule
