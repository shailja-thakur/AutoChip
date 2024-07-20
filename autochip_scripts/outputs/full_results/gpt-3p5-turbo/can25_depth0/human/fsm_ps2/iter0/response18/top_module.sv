module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0;
		done_reg <= 1'b0;
	end else begin
		case (state)
			2'b00: begin
				if (in[3] == 1'b1)
					state <= 2'b01;
			end
			2'b01: begin
				state <= 2'b10;
			end
			2'b10: begin
				if (in[3] == 1'b1) begin
					state <= 2'b01;
					done_reg <= 1'b1;
				end
			end
		endcase
	end
end

assign done = done_reg;

endmodule
