module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Define states
	parameter OFF = 0;
	parameter ON = 1;

	// Define state register
	reg state;
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= OFF; // Reset to OFF state
		end else begin
			case(state)
				OFF: begin
					if (j) begin
						state <= ON; // Transition to ON state
					end else begin
						state <= OFF; // Stay in OFF state
					end
				end
				ON: begin
					if (k) begin
						state <= OFF; // Transition to OFF state
					end else begin
						state <= ON; // Stay in ON state
					end
				end
				default: state <= OFF; // Reset to OFF state if invalid state occurs
			endcase
		end
	end

	// Define output register
	reg out_reg;
	always @(state) begin
		case(state)
			OFF: out_reg = 0; // Output 0 in OFF state
			ON: out_reg = 1; // Output 1 in ON state
			default: out_reg = 0; // Default output 0 for invalid states
		endcase
	end

	// Assign regulated output to output port
	assign out = out_reg;

endmodule
