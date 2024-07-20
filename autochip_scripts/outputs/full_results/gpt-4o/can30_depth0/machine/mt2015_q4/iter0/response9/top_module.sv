module top_module(
	input x,
	input y,
	output z);

    wire out1, out2;
  
    // First logic gate
    and (out1, x, y);
  
    // Second logic gate
    or (out2, y, x);
  
    // Third logic gate
    xor (z, out1, out2);  

endmodule
