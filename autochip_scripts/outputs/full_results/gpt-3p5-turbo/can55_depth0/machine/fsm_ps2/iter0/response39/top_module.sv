module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	
	// Define states
	parameter BYTE1 = 2'b00;
	parameter BYTE2 = 2'b01;
	parameter BYTE3 = 2'b10;
	parameter DONE = 2'b11;
	
	// Define registers
	reg [1:0] state_reg;
	reg [1:0] next_state;
	reg done_reg;
	
	// Assign next state based on current state and input
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= BYTE1;
			done_reg <= 0;
		end else begin
			state_reg <= next_state;
			done_reg <= (state_reg == DONE);
		end
	end
	
	// Determine next state based on current state and input
	always @(state_reg or in) begin
		case (state_reg)
			BYTE1: begin
				if (in[2] == 1'b1) begin
					next_state <= BYTE2;
				end else begin
					next_state <= BYTE1;
				end
			end
			BYTE2: begin
				next_state <= BYTE3;
			end
			BYTE3: begin
				next_state <= DONE;
			end
			DONE: begin
				if (in[2] == 1'b1) begin
					next_state <= BYTE2;
				end else begin
					next_state <= BYTE1;
				end
			end
		endcase
	end
	
	// Assign output
	assign done = done_reg;
	
endmodule
