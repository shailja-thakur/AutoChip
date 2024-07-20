module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);

	// Internal signals
	reg [63:0] q_temp;

	// Synchronous load
	always @(posedge clk) begin
		if (load) begin
			q_temp <= data;
		end else if (ena) begin
			case (amount)
				2'b00: q_temp <= q_temp << 1;
				2'b01: q_temp <= q_temp << 8;
				2'b10: q_temp <= q_temp >> 1;
				2'b11: q_temp <= q_temp >> 8;
			endcase
		end
	end

	// Output assignment
	always @(posedge clk) begin
		q <= q_temp;
	end

endmodule
