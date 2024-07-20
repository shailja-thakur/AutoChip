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
		state <= 3'b0;
		done_reg <= 1'b0;
	end else begin
		case (state)
			3'b000: begin
				if (in[3] == 1'b1) begin
					state <= 3'b001;
				end
			end
			3'b001: begin
				state <= 3'b010;
			end
			3'b010: begin
				state <= 3'b011;
			end
			3'b011: begin
				state <= 3'b000;
				done_reg <= 1'b1;
			end
			default: begin
				state <= 3'b0;
			end
		endcase
	end
end

assign done = done_reg;

endmodule
