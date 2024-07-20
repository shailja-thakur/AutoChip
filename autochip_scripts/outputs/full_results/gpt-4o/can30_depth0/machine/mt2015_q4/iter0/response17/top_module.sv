module top_module(
	input x,
	input y,
	output z);

    wire out1, out2;
    
    // First gate, using AND gate as example
    assign out1 = x & y;
    
    // Second gate, using OR gate as example
    assign out2 = x | y;
    
    // Third gate, using XOR gate as example
    assign z = out1 ^ out2;
    
endmodule
