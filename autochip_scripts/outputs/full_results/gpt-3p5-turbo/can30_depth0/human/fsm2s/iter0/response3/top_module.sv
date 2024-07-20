module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00; // OFF state
		end else begin
			case (state)
				2'b00: begin // OFF state
					if (j) begin
						state <= 2'b01; // Transition to ON state
					else
						state <= 2'b00; // Remain in OFF state
					end
				end
				2'b01: begin // ON state
					if (k) begin
						state <= 2'b00; // Transition to OFF state
					else
						state <= 2'b01; // Remain in ON state
					end
				end
				default: state <= 2'b00;
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			2'b00: out <= 1'b0; // OFF state, output is 0
			2'b01: out <= 1'b1; // ON state, output is 1
			default: out <= 1'b0; // Default to OFF state
		endcase
	end
	
endmodule
