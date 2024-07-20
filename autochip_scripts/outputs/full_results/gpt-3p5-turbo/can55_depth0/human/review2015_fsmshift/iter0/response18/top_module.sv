module top_module(
	input clk,
	input reset,
	output shift_ena);

	// Internal signals
	reg [1:0] state;
	reg [1:0] next_state;
	reg [3:0] count;
	reg enable;

	// FSM states
	parameter IDLE = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;
	
	// Detect bit pattern
	assign enable = (count == 4'b1010);

	// State transition and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			count <= 0;
			shift_ena <= 1'b0;
		end else begin
			state <= next_state;
			count <= count + 1;
			shift_ena <= enable;
		end
	end

	// Next state logic
	always @(state, enable) begin
		case (state)
			IDLE: begin
				if (enable)
					next_state <= S1;
				else
					next_state <= IDLE;
			end
			S1: begin
				next_state <= S2;
			end
			S2: begin
				next_state <= S3;
			end
			S3: begin
				next_state <= IDLE;
			end
		endcase
	end

endmodule
