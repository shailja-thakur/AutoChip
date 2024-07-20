module top_module(
  input clk,
  input d,
  output reg q
);

	// Define internal wires and registers
	wire d_sync;
	reg q_sync;
	
	// Synchronize the input signal d with the clock signal
	always @(posedge clk) begin
		q_sync <= d;
	end
	
	// Assign the synchronized value to the output register q
	assign q = q_sync;
	
endmodule
