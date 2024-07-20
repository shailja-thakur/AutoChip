module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output [63:0] q
);

	reg [63:0] q_reg;

	always @(posedge clk) begin
		if (load) begin
			q_reg <= {q_reg[62:0], 1'b0}; // Case item 00
		end
		else if (ena) begin
			case (amount)
				2'b01: q_reg <= {q_reg[55:0], 8'b0};
				2'b10: q_reg <= {q_reg[63], q_reg[63:1]};
				2'b11: q_reg <= {{8{q_reg[63]}}, q_reg[63:8]};
				default: q_reg <= 64'hx;
			endcase
		end
	end

	assign q = q_reg;

endmodule
