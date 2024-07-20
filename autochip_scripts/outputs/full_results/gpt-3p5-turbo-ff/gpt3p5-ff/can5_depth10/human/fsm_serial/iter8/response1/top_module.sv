module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

	reg [3:0] state; // FSM state register
	reg [7:0] data; // Received data register

	always @(posedge clk or posedge reset) begin
	    if (reset)
	        state <= 0;
	    else
	        case (state)
	            0: begin // Idle state, wait for start bit
                    if (in == 1'b0)
                        state <= 1;
	            end
                1: begin // Receive data bits
                    state <= 2;
                    data <= 0;
                end
                2: begin // Receive data bits
                    data <= {in, data[7:1]};
                    state <= 3;
                end
                3: begin // Verify stop bit
                    if (in == 1'b1 && data == 8'b01111110)
                        state <= 4;
                    else
                        state <= 0;
                end
                4: begin // Wait for idle state
                    if (in == 1'b1)
                        state <= 4;
                    else
                        state <= 0;
                end
	        endcase
	end

	always @(posedge clk) begin
	    if (reset)
	        done <= 0;
	    else if (state == 0 && in == 1'b1)
	        done <= 0;
	    else if (state == 4)
	        done <= 1;
	end
	        
endmodule
