module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] state, next_state;
	reg [1:0] count;
	
	// State encoding
	localparam  IDLE  = 2'b00,
				SHIFT = 2'b01,
				DONE  = 2'b10;

	// State transition logic
	always @(*) begin
		case (state)
			IDLE:  next_state = reset ? SHIFT : IDLE;
			SHIFT: next_state = (count == 2'b11) ? DONE : SHIFT;
			DONE:  next_state = DONE;
			default: next_state = IDLE;
		endcase
	end

	// Sequential block for state and counter updates
	always @(posedge clk) begin
		if (reset) begin
			state <= SHIFT;
			count <= 0;
		end
		else begin
			state <= next_state;
			if (state == SHIFT) begin
				count <= count + 1;
			end
		end
	end

	// Output logic
	always @(*) begin
		case (state)
			SHIFT: shift_ena = 1;
			default: shift_ena = 0;
		endcase
	end

endmodule
