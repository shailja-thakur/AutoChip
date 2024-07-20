module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
	
	// Internal signals
	reg [3:0] delay;   // Delay duration
	reg [1:0] state;   // State machine state
	reg [3:0] counter; // Counter for current state
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset state and outputs
			state <= 2'b00;
			delay <= 4'b0;
			counting <= 0;
			done <= 0;
			counter <= 4'b0;
		end else begin
			// State machine
			case(state)
				2'b00: begin // Wait for start pattern (1101)
					if (data == 4'b1101) begin
						state <= 2'b01;
					end
				end
				
				2'b01: begin // Shift in delay[3:0]
					delay <= {delay[2:0], data};
					state <= 2'b10;
				end
				
				2'b10: begin // Start counting
					counting <= 1;
					
					// Counter logic
					if (counter < ((delay + 1) * 1000) - 1) begin
						counter <= counter + 1;
					end else begin
                        counting <= 0;
						done <= 1;
					end
					
					// Remaining time output
					count <= delay;
					
				    state <= 2'b11;
				end
                
                2'b11: begin // Wait for acknowledge
                    if (ack) begin
                        // Reset state and outputs
                        state <= 2'b00;
                        delay <= 4'b0;
                        counting <= 0;
                        done <= 0;
                        counter <= 4'b0;
                    end
                end
			endcase
		end
	end
endmodule
