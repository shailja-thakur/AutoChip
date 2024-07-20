module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b0;
		else
		begin
			case (state)
				2'b00: // OFF state
					begin
						if (j)
							state <= 2'b01; // Transition to ON state if j is high
						else
							state <= 2'b00; // Remain in OFF state if j is low
					end
				2'b01: // ON state
					begin
						if (k)
							state <= 2'b00; // Transition to OFF state if k is high
						else
							state <= 2'b01; // Remain in ON state if k is low
					end
				default:
					state <= 2'b00; // Default state is OFF
			endcase
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is high in ON state, low otherwise

endmodule
