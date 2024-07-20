module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

	reg [1:0] state;
	reg [23:0] buffer;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			buffer <= 24'b0;
		end else begin
			case (state)
				0: begin // Idle state
					if (in[3] == 1'b1) begin
						state <= 1;
						buffer[23:16] <= in;
					end
				end
				
				1: begin // Waiting for second byte
					state <= 2;
					buffer[15:8] <= in;
				end
				
				2: begin // Waiting for third byte
					state <= 3;
					buffer[7:0] <= in;
				end
				
				3: begin // Output bytes and signal done
					state <= 0;
					done <= 1;
					out_bytes <= buffer;
				end
			endcase
		end
	end

endmodule
