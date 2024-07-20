module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// Define states
parameter S_IDLE = 2'b00;
parameter S_WAITING = 2'b01;
parameter S_RECEIVING = 2'b10;

reg [1:0] state;
reg done;

// Flip-flops for storing previous values
reg [7:0] prev_in;
reg prev_in3;

always @(posedge clk) begin
	if (reset) begin
		state <= S_IDLE;
		done <= 0;
		prev_in <= 0;
		prev_in3 <= 0;
	end else begin
		case (state)
			S_IDLE:
				if (in[3] == 1'b1) begin
					state <= S_WAITING;
				end
			S_WAITING:
				if (in[3] == 1'b1 && prev_in3 == 1'b0) begin
					state <= S_RECEIVING;
				end
			S_RECEIVING:
				if (in[3] == 1'b0 && prev_in3 == 1'b1) begin
					state <= S_WAITING;
				end else if (in[3] == 1'b1 && prev_in3 == 1'b1 && prev_in[3] == 1'b1) begin
					state <= S_IDLE;
					done <= 1;
				end
			default:
				state <= S_IDLE;
		endcase
		
		prev_in <= in;
		prev_in3 <= in[3];
	end
end

endmodule
