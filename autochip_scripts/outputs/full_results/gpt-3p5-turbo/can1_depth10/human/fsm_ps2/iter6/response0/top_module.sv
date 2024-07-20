module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

reg [2:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
wire [7:0] in_reg;
reg reset_reg;

always @(posedge clk) begin
	if (reset)
		reset_reg <= 1;
	else if (!reset && reset_reg)
		reset_reg <= 0;
end

always @(posedge clk or posedge reset_reg) begin
	if (reset_reg)
		state <= 0;
	else begin
		case(state)
			0: begin // IDLE state
				if (in_reg[3] && !reset_reg) begin
					state <= 1; // Transition to ACCEPT_BYTE1 state
					byte1 <= in_reg;
				end
				else
					state <= 0; // Stay in IDLE state
			end
			1: begin // ACCEPT_BYTE1 state
				if (!reset_reg) begin
					state <= 2; // Transition to ACCEPT_BYTE2 state
					byte2 <= in_reg;
				end
				else
					state <= 0; // Transition to IDLE state
			end
			2: begin // ACCEPT_BYTE2 state
				if (!reset_reg) begin
					state <= 3; // Transition to ACCEPT_BYTE3 state
					byte3 <= in_reg;
				end
				else
					state <= 0; // Transition to IDLE state
			end
			3: begin // ACCEPT_BYTE3 state
				if (!reset_reg) begin
					state <= 4; // Transition to DONE state
				end
				else
					state <= 0; // Transition to IDLE state
			end
			4: begin // DONE state
				state <= 0; // Transition back to IDLE state
				done <= 1; // Set done register
			end
			default: begin
				state <= 0; // Default case: transition back to IDLE state
			end
		endcase
	end
end

assign in_reg = in;

endmodule
