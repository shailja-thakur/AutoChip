module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// State definitions
	parameter IDLE = 2'b00;
	parameter BYTE1_RECEIVED = 2'b01;
	parameter BYTE2_RECEIVED = 2'b10;
	parameter BYTE3_RECEIVED = 2'b11;
	
	// Signals
	reg [1:0] state;
	reg done;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			done <= 0;
		end else begin
			case (state)
				IDLE:
					if (in[3] == 1)
						state <= BYTE1_RECEIVED;
					else
						state <= IDLE;
				BYTE1_RECEIVED:
					state <= BYTE2_RECEIVED;
				BYTE2_RECEIVED:
					state <= BYTE3_RECEIVED;
				BYTE3_RECEIVED:
					begin
						state <= IDLE;
						done <= 1;
					end
				default:
					state <= IDLE;
				
			endcase
		end
	end
endmodule
