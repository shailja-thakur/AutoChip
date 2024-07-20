module top_module(
	output reg one); // added reg to declare one as a register

  always @(posedge clk) // added a clock signal for synchronous operation
    one <= 1'b1; // always drive one with logic high
  
endmodule
