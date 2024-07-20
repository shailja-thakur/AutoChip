module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	
	// Finite state machine states
	parameter IDLE = 2'b00;
	parameter BYTE1 = 2'b01;
	parameter BYTE2 = 2'b10;
	parameter BYTE3 = 2'b11;
	
	// Internal signals
	reg [1:0] state;
	reg done;
	reg valid_message;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			done <= 0;
			valid_message <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (in[3]) begin
						state <= BYTE1;
						valid_message <= 0;
					end
				end
				
				BYTE1: begin
					if (!in[3]) begin
						state <= IDLE;
					end else begin
						state <= BYTE2;
					end
				end
				
				BYTE2: begin
					if (!in[3]) begin
						state <= IDLE;
					end else begin
						state <= BYTE3;
					end
				end
				
				BYTE3: begin
					if (!in[3]) begin
						state <= IDLE;
					end else begin
						state <= IDLE;
						valid_message <= 1;
						done <= 1;
					end
				end
			endcase
		end
	end
	
endmodule
