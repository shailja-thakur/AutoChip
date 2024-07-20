module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
	parameter IDLE = 2'b00;
	parameter FOUND_FIRST_BYTE = 2'b01;
	parameter RECEIVING_MSG = 2'b10;
	parameter MSG_COMPLETE = 2'b11;
	
	reg [1:0] state, next_state;
	reg done;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			done <= 0;
		end else begin
			state <= next_state;
			done <= (state == MSG_COMPLETE) ? 1 : 0;
		end
	end
	
	always @(state or in) begin
		next_state = state;
		case (state)
			IDLE: begin
				if (in[3]) begin
					next_state = FOUND_FIRST_BYTE;
				end
			end
			FOUND_FIRST_BYTE: begin
				next_state = (in[3]) ? FOUND_FIRST_BYTE : RECEIVING_MSG;
			end
			RECEIVING_MSG: begin
				next_state = (in[3]) ? FOUND_FIRST_BYTE : MSG_COMPLETE;
			end
			MSG_COMPLETE: begin
				next_state = IDLE;
			end
		endcase
	end
endmodule
