module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] shift_reg;
	wire [99:0] shifted_data;

	always @(posedge clk) begin
		if (load)
			shift_reg <= data;
		else begin
			case (ena)
				2'b01: shifted_data <= {shift_reg[0], shift_reg[99:1]};
				2'b10: shifted_data <= {shift_reg[98:0], shift_reg[99]};
				default: shifted_data <= shift_reg;
			endcase
			shift_reg <= shifted_data;
		end
	end

	assign q = shifted_data;

endmodule
