module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= 2'b10;
		out <= 1'b1;
	end else begin
		case (state)
			2'b00: begin // State B
				if (in) begin
					state <= 2'b10; // Stay in state B
					out <= 1'b1;
				end else begin
					state <= 2'b01; // Transition to state A
					out <= 1'b0;
				end
			end

			2'b01: begin // State A
				if (in) begin
					state <= 2'b01; // Stay in state A
					out <= 1'b0;
				end else begin
					state <= 2'b10; // Transition to state B
					out <= 1'b1;
				end
			end

			default: state <= 2'b00;
		endcase
	end
end
endmodule
