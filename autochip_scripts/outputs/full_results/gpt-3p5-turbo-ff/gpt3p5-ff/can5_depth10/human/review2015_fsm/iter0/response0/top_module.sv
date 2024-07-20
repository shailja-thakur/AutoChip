module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

	// Define states
	typedef enum logic [2:0] {
		START,
		SHIFT_ENA,
		COUNTING,
		DONE,
		WAIT_FOR_ACK
	} state_type;
	
	// Define register to hold current state
	reg [2:0] current_state;
	
	// Define next state
	state_type next_state;
	
	always @(posedge clk) begin
		if (reset)
			current_state <= START;
		else
			current_state <= next_state;
	end
	
	always @* begin
		next_state = current_state;
		shift_ena = 0;
		counting = 0;
		done = 0;
		if (reset)
			next_state = START;
		else begin
			case (current_state)
				START:
					if (data == 4'b1101)
						next_state = SHIFT_ENA;
				SHIFT_ENA:
					shift_ena = 1;
					next_state = COUNTING;
				COUNTING:
					counting = 1;
					if (done_counting)
						next_state = DONE;
				DONE:
					done = 1;
					if (ack)
						next_state = WAIT_FOR_ACK;
				WAIT_FOR_ACK:
					if (ack)
						next_state = START;
			endcase
		end
	end
	
endmodule
