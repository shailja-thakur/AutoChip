module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] q_reg;

	always @(posedge clk) begin
		if (load) begin
			q_reg <= data;
		end else begin
			case(ena)
				2'b01: q_reg <= {q_reg[98:0], data[99]};
				2'b10: q_reg <= {data[0], q_reg[99:1]};
				default: q_reg <= q_reg;
			endcase
		end
	end

	assign q = q_reg;

endmodule
