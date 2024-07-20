module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

	reg [3:0] state; // FSM state register
	reg [7:0] data; // Received data register

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
					data <= 0;
				end
				2: begin // Receive data bits
					data <= {data[6:0], in};
					state <= 3;
				end
				3: begin // Verify stop bit
					if (in == 1 && data == 8'b01111110) // Check for correct stop bit
						state <= 0; // Go back to idle state
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
	    else
	        done <= (state == 0); // Output high when byte is received correctly
	end

endmodule
