module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	// Define states
	enum {OFF, ON} state;

	// State register
	reg [1:0] current_state;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= OFF;
		end
		else begin
			case (current_state)
				ON: begin
					if (k) begin
						current_state <= OFF;
					end
					else begin
						current_state <= ON;
					end
				end
				OFF: begin
					if (j) begin
						current_state <= ON;
					end
					else begin
						current_state <= OFF;
					end
				end
				default: current_state <= OFF;
			endcase
		end
	end

	// Output logic
	always @(current_state) begin
		case (current_state)
			ON: out <= 1'b1;
			OFF: out <= 1'b0;
			default: out <= 1'b0;
		endcase
	end
endmodule
