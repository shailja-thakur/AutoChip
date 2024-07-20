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
		state <= 2'b10; // B
		out <= 1; // Output is initially high in B state
	end else begin
		case (state)
			2'b00: begin // A
				if (in)
					state <= 2'b01; // Stay in A state
				else
					state <= 2'b10; // Transition to B state
			end
			2'b01: begin // B
				if (in)
					state <= 2'b01; // Stay in B state
				else
					state <= 2'b10; // Transition to A state
			end
			default: state <= 2'b10; // B (default case)
		endcase
	end
end

assign out = (state == 2'b01) ? 0 : 1;

endmodule
