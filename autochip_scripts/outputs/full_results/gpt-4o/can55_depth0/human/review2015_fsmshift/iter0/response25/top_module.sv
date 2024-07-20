module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] state, next_state;
	reg [2:0] count, next_count;
	
	// State encoding
	localparam IDLE = 2'b00,
	           SHIFT = 2'b01,
	           DONE = 2'b10;
	
	// State transition logic
	always @ (posedge clk) begin
		if (reset) begin
			state <= SHIFT;
			count <= 3'b100; // 4 cycles
		else begin
			state <= next_state;
			count <= next_count;
		end
	end
	
	// Next state logic and shift enable signal
	always @ (*) begin
		case (state)
			IDLE: begin
				shift_ena = 1'b0;
				if (reset) begin
					next_state = SHIFT;
					next_count = 3'b100; // 4 cycles
				end
				else begin
					next_state = IDLE;
					next_count = 3'b000;
				end
			end
			SHIFT: begin
				shift_ena = 1'b1;
				if (count > 3'b000) begin
					next_state = SHIFT;
					next_count = count - 1;
				end
				else begin
					next_state = DONE;
					next_count = 3'b000;
				end
			end
			DONE: begin
				shift_ena = 1'b0;
				next_state = DONE;
				next_count = 3'b000;
			end
			default: begin
				shift_ena = 1'b0;
				next_state = IDLE;
				next_count = 3'b000;
			end
		endcase
	end
	
endmodule
