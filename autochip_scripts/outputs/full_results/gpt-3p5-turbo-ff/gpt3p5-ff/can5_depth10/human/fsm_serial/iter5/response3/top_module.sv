module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

	reg [3:0] state; // FSM state register
	reg [7:0] data; // Received data register
	reg [2:0] bit_count; // Bit count register

	// Start bit detection
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case(state)
				0: begin // Idle state, wait for start bit
					if (in == 1'b0)
						state <= 1;
				end
				1: begin // Receive data bits
					state <= 2;
					bit_count <= 0;
					data <= 0;
				end
				2: begin // Receive data bits
					data <= {data[6:0], in};
					bit_count <= bit_count + 1;
					state <= 3;
				end
				3: begin // Verify stop bit
					if (in == 1 && bit_count == 8 && data == 8'b01111110) // Check for correct stop bit
						state <= 0; // Go back to idle state
					else if (bit_count == 8) // If 8 bits are received without correct stop bit, wait for stop bit
						state <= 3;
				end
			endcase
		end
	end

	// Output control
	always @(posedge clk) begin
	    if (reset)
	        done <= 0;
	    else if (state == 0 && in == 1'b1) // Reset done signal if input line is idle
	        done <= 0;
	    else if (state == 0 && in == 1'b0) begin // Reset data and bit count registers if input line becomes active when in idle state
	        data <= 0;
	        bit_count <= 0;
	    end else
	        done <= (state == 0); // Output high when byte is received correctly
	end

endmodule
