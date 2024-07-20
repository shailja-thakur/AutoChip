module top_module(
	input clk,
	input reset,
	output reg shift_ena
);

	reg [1:0] state, next_state;
	reg [2:0] shift_counter;
    
    // State encoding
	localparam IDLE = 2'b00;
	localparam SHIFT = 2'b01;
	localparam DONE = 2'b10;

	// State transition logic
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: begin
				if (reset)
					next_state = SHIFT;
				else
					next_state = IDLE;
			end
			SHIFT: begin
				if (shift_counter == 3'b100)
					next_state = DONE;
				else
					next_state = SHIFT;
			end
			DONE: begin
				next_state = DONE;
			end
			default: next_state = IDLE;
		endcase
	end

	// Output logic and counter
	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1;
			shift_counter <= 0;
		end else if (state == SHIFT) begin
			if (shift_counter < 3'b100) begin
				shift_ena <= 1;
				shift_counter <= shift_counter + 1;
			end else begin
				shift_ena <= 0;
			end
		end else begin
			shift_ena <= 0;
		end
	end
endmodule
