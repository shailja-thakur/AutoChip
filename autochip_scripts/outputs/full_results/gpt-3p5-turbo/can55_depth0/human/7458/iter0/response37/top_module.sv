module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d,
	input p1e,
	input p1f,
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

    wire p1and1_output, p1and2_output, p2and1_output, p2and2_output;
    
    assign p1and1_output = p1a & p1b & p1c;
    assign p1and2_output = p1d & p1e & p1f;
    assign p2and1_output = p2a & p2b;
    assign p2and2_output = p2c & p2d;
    
    assign p1y = p1and1_output | p1and2_output;
    assign p2y = p2and1_output | p2and2_output;

endmodule
