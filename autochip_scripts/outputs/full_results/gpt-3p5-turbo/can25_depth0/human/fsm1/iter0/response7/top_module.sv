module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always@(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b01; // reset to state B
		out <= 0;
	end
	else begin
		case(state)
			2'b00: begin // state A
				if (in) begin
					state <= 2'b01; // transition to state B
					out <= 1;
				end
				else begin
					state <= 2'b00; // stay in state A
					out <= 0;
				end
			end
			2'b01: begin // state B
				if (in) begin
					state <= 2'b01; // stay in state B
					out <= 0;
				end
				else begin
					state <= 2'b00; // transition to state A
					out <= 1;
				end
			end
			default: begin
				state <= 2'b01; // reset to state B
				out <= 0;
			end
		endcase
	end
end

endmodule
