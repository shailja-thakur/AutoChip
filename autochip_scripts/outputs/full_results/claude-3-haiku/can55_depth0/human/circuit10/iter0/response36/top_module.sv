module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg current_state;

always @(posedge clk) begin
	case ({a, b})
		2'b00: begin
			current_state <= current_state;
			q <= q;
		end
		2'b01: begin
			current_state <= 1'b0;
			q <= 1'b1;
		end
		2'b10: begin
			current_state <= 1'b0;
			q <= 1'b0;
		end
		2'b11: begin
			current_state <= 1'b1;
			q <= 1'b0;
		end
	endcase
	state <= current_state;
end

endmodule
