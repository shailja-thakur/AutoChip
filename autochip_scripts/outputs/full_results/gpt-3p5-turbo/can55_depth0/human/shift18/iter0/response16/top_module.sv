module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);

	// Internal signals
	reg [63:0] shifter;

	always @(posedge clk) begin
		if (load) begin
			shifter <= data;
		end else if (ena) begin
			case (amount)
				2'b00: shifter <= shifter << 1;
				2'b01: shifter <= shifter << 8;
				2'b10: shifter <= shifter[63] ? {32'd1, shifter[63:1]} : shifter >> 1;
				2'b11: shifter <= shifter >> 8;
				default: shifter <= shifter;
			endcase
		end
	end

	assign q = shifter;
endmodule
