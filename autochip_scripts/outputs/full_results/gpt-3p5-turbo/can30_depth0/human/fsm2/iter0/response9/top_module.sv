module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define the states
	localparam OFF = 0;
	localparam ON = 1;
	
	// Define the current state variable
	reg [1:0] current_state;
	
	// Next state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= OFF;
		end else begin
			case (current_state)
				OFF: begin
					if (j) begin
						current_state <= ON;
					end else begin
						current_state <= OFF;
					end
				end
				ON: begin
					if (k) begin
						current_state <= OFF;
					end else begin
						current_state <= ON;
					end
				end
				default: current_state <= OFF;
			endcase
		end
	end
	
	// Output logic
	always @(current_state) begin
		case (current_state)
			OFF: out <= 0;
			ON: out <= 1;
			default: out <= 0;
		endcase
	end
	
endmodule
