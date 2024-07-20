module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg out_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		out_reg <= 0;
	end else begin
		case (state)
			0: begin
				if (j) begin
					state <= 1;
					out_reg <= 0;
				end
			end
			1: begin
				if (!k) begin
					state <= 1;
					out_reg <= 1;
				end else begin
					state <= 0;
					out_reg <= 1;
				end
			end
		endcase
	end
end

assign out = out_reg;

endmodule
