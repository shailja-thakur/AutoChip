module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] shift_reg;

	always @(posedge clk) begin
		if (load) begin
			shift_reg <= data;
		end else begin
			case (ena)

				2'b01 : begin
					shift_reg <= {1'b0, shift_reg[99:1]};
				end

				2'b10 : begin
					shift_reg <= {shift_reg[98:0], 1'b0};
				end

				default : begin
					shift_reg <= shift_reg;
				end
			endcase
		end
	end

	assign q = shift_reg;

endmodule
