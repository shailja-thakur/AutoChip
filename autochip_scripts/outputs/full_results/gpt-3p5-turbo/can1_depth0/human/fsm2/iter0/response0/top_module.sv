module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b0;
		else begin
			case (state)
				2'b00: begin // OFF state
					if (j == 1)
						state <= 2'b01; // Transition to ON state
					else
						state <= 2'b00; // Remain in OFF state
				end
				2'b01: begin // ON state
					if (k == 1)
						state <= 2'b00; // Transition to OFF state
					else
						state <= 2'b01; // Remain in ON state
				end
				default: state <= 2'b0;
			endcase
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is 1 in ON state, 0 otherwise

endmodule
