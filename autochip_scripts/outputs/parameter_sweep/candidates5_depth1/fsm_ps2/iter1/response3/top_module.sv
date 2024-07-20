module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	reg [2:0] state;
	reg [2:0] next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			done <= 1'b0;
		end else begin
			state <= next_state;
		end
	end

	always @* begin
		next_state = state;
		
		case (state)
			3'b000: begin // Find first byte of message
				if (in[3] == 1'b1) begin
					next_state = 3'b001;
				end
			end
			3'b001: begin // Receive second byte of message
				next_state = 3'b010;
			end
			3'b010: begin // Receive third byte of message
				next_state = 3'b011;
			end
			3'b011: begin // Wait one cycle after third byte to signal done
				next_state = 3'b000;
				done <= 1'b1;
			end
			default: begin
				next_state = 3'b000;
			end
		endcase
	end

endmodule
