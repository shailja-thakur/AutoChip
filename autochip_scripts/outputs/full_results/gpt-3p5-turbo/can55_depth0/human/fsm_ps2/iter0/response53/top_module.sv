module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// State definitions
	parameter IDLE = 2'b00;
	parameter FIRST_BYTE = 2'b01;
	parameter SECOND_BYTE = 2'b10;
	parameter THIRD_BYTE = 2'b11;
	
	reg [1:0] state;
	reg done;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			done <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (in[3] == 1) begin
						state <= FIRST_BYTE;
					end else begin
						state <= IDLE;
					end
				end
				FIRST_BYTE: begin
					state <= SECOND_BYTE;
				end
				SECOND_BYTE: begin
					state <= THIRD_BYTE;
				end
				THIRD_BYTE: begin
					state <= IDLE;
					done <= 1;
				end
				default: state <= IDLE;
			endcase
		end
	end
endmodule
