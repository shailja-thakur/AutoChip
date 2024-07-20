module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg [7:0] in_reg;
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		in_reg <= 8'b0;
		done_reg <= 0;
	end else begin
		in_reg <= in;
		case (state)
			0: begin
				if (in_reg[3] == 1) begin
					state <= 1;
				end
			end
			1: begin
				if (in_reg[3] == 1) begin
					state <= 2;
				end else begin
					state <= 0;
				end
			end
			2: begin
				if (in_reg[3] == 1) begin
					if (done_reg) begin
						state <= 0;
					end else begin
						state <= 3;
						done_reg <= 1;
					end
				end else begin
					state <= 0;
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
