module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

reg state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= STATE_B;
		out <= 1'b1;
	end
	else begin
		case (state)
			STATE_A: begin
				if (in) begin
					state <= STATE_A;
					out <= 1'b0;
				end
				else begin
					state <= STATE_B;
					out <= 1'b0;
				end
			end
			STATE_B: begin
				if (in) begin
					state <= STATE_B;
					out <= 1'b1;
				end
				else begin
					state <= STATE_A;
					out <= 1'b1;
				end
			end
		endcase
	end
end

endmodule
