module top_module(
	output zero);

  always @(posedge clock)
    zero <= 0;
  
endmodule
