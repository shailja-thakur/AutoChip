module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	// Internal signals
	reg [31:0] next_q;
	
	// LFSR taps
	reg tap_32, tap_22, tap_2, tap_1;
	
	// Assign taps
	assign tap_32 = q[31];
	assign tap_22 = q[21];
	assign tap_2 = q[1];
	assign tap_1 = q[0];
	
	// Next state generation
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			next_q <= 32'h1;
		end else begin
			next_q <= {q[30:0], tap_32 ^ tap_22 ^ tap_2 ^ tap_1};
		end
	end
	
	// Output assignment
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q <= next_q;
		end
	end
	
endmodule
