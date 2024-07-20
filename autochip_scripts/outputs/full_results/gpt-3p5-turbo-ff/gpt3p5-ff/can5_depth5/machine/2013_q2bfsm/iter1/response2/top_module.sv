module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 1'b0;
			g <= 1'b0;
		end else begin
			case (state_reg)
				B: f <= 1'b1;
				G1, G2, P1: g <= 1'b1;
				default: g <= 1'b0;
			endcase
		end
	end
endmodule
