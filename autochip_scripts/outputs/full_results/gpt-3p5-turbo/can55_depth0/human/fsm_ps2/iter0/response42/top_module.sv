module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		done_reg <= 0;
	end
	else begin
		case (state)
			0: begin
				if (in[3])
					state <= 1;
			end
			1: begin
				if (!in[3])
					state <= 0;
				else
					state <= 2;
			end
			2: begin
				if (!in[3])
					state <= 0;
				else begin
					state <= 3;
					done_reg <= 1;
				end
			end
			3: begin
				state <= 0;
			end
		endcase
	end
end

assign done = done_reg;

endmodule
