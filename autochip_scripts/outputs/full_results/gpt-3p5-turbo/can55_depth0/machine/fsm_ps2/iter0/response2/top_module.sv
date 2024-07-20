module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	
	// Define states
	parameter BYTE1 = 0;
	parameter BYTE2 = 1;
	parameter BYTE3 = 2;
	parameter DONE = 3;
	
	// Define registers for state and next state
	reg [1:0] state_reg;
	reg [1:0] state_next;
	
	// Define logic for state transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= BYTE1;
		end else begin
			state_reg <= state_next;
		end
	end
	
	// Define logic for next state calculation
	always @(*) begin
		case(state_reg)
			BYTE1: begin
				if (in[2] == 1) begin
					state_next = BYTE2;
				end else begin
					state_next = BYTE1;
				end
			end
			BYTE2: begin
				state_next = BYTE3;
			end
			BYTE3: begin
				state_next = DONE;
			end
			DONE: begin
				if (in[2] == 1) begin
					state_next = BYTE2;
				end else begin
					state_next = BYTE1;
				end
			end
			default: begin
				state_next = BYTE1;
			end
		endcase
	end
	
	// Define logic for done signal
	assign done = (state_reg == DONE);
	
endmodule
