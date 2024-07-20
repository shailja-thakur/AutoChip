module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg done;

parameter IDLE = 0;
parameter START_BIT = 1;
parameter DATA_BITS = 2;
parameter STOP_BIT = 3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		done <= 0;
	end else begin
		case(state)
			IDLE: begin
				if (in == 0)
					state <= START_BIT;
			end
			START_BIT: begin
				if (in == 0)
					state <= DATA_BITS;
				else
					state <= IDLE;
			end
			DATA_BITS: begin
				if (in == 1)
					state <= STOP_BIT;
				else 
					state <= DATA_BITS;
			end
			STOP_BIT: begin
				if (in == 1) begin
					state <= IDLE;
					done <= 1;
				end else
					state <= START_BIT;
			end
		endcase
	end
end

endmodule
