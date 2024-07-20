module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state = 0; // initialize state to B

always@(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b01; // reset to B
	end
	else begin
		case(state)
			2'b01: begin // state B
				if (in) begin
					state <= 2'b01; // stay in B
				end
				else begin
					state <= 2'b10; // transition to A
				end
			end

			2'b10: begin // state A
				if (in) begin
					state <= 2'b10; // stay in A
				end
				else begin
					state <= 2'b01; // transition to B
				end
			end

			default: state <= 2'b01; // default to B
		endcase
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // output 1 in state B, 0 otherwise

endmodule
