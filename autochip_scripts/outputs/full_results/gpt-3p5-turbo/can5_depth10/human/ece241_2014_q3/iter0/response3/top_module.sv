module top_module (
  	input c,
  	input d,
  	output [3:0] mux_in
);
  	
  	// Define the intermediate signals
  	wire cd_00, cd_01, cd_11, cd_10;
  	wire a, b;
  	
  	// Assign the mux selectors
  	assign a = c;
  	assign b = d;

  	// Implement the K-map using 2-to-1 multiplexers
  	// CD = 00
  	assign mux_in[0] = cd_00 ? 1'b1 : 1'b0;
  	// CD = 01
  	assign mux_in[1] = cd_01 ? 1'b1 : 1'b0;
  	// CD = 11
  	assign mux_in[2] = cd_11 ? 1'b1 : 1'b0;
  	// CD = 10
  	assign mux_in[3] = cd_10 ? 1'b1 : 1'b0;

  	// Implement the 4-to-1 multiplexer
  	assign cd_00 = (a & b) ? 1'b0 : 1'b1;
  	assign cd_01 = ((~a) & b) ? 1'b0 : 1'b1;
  	assign cd_11 = ((~a) & (~b)) ? 1'b0 : 1'b1;
  	assign cd_10 = (a & (~b)) ? 1'b0 : 1'b1;
  	
endmodule
