module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// Internal signals
	reg [2:0] state;
	reg [7:0] data;
	reg stop_bit;
	
	// State definitions
	parameter START = 3'b000;
	parameter DATA = 3'b001;
	parameter STOP = 3'b010;
	parameter WAIT = 3'b011;
	
	// Reset state
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= START;
	end
	
	// State transition and output generation
	always @(posedge clk)
	begin
		case (state)
			START: // Wait for the start bit (0)
				begin
					data <= 8'b0;
					if (in == 0)
						state <= DATA;
					else
						state <= START;
				end
				
			DATA: // Wait for 8 data bits
				begin
					data <= {data[6:0], in};
					if (stop_bit == 1)
						state <= STOP;
					else
						state <= DATA;
				end
				
			STOP: // Verify the stop bit (1)
				begin
					if (in == 1)
						state <= WAIT;
					else
						state <= START;
				end
				
			WAIT: // Wait for the next start bit
				begin
					if (in == 0)
						state <= START;
					else
						state <= WAIT;
				end
		endcase
		
		// Generate done signal when a byte has been correctly received
		if (state == STOP)
			done <= 1;
		else
			done <= 0;
	end
	
endmodule
