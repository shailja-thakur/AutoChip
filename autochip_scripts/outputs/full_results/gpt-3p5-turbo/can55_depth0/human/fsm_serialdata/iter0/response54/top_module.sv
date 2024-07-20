module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// Enumeration for state names
	typedef enum logic [2:0] {
		START,
		DATA,
		STOP
	} state_t;

	reg [2:0] state, next_state;

	// Synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= START;
		else
			state <= next_state;
	end

	// State transition logic
	always @* begin
		next_state = state;
		case (state)
			START: begin
				if (in == 0)
					next_state = DATA;
			end

			DATA: begin
				if (in == 1)
					next_state = STOP;
			end

			STOP: begin
				if (in == 1)
					next_state = START;
				else
					out_byte <= in[7:0];
					done <= 1;
				end
			endcase
		end
	end
	
	// Output assignment
	assign done = 0;
	
endmodule
