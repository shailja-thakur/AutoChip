module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

reg [3:0] state;

parameter IDLE = 0;
parameter START_BIT = 1;
parameter DATA_BITS = 2;
parameter STOP_BIT = 3;

// Synchronous reset
always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		out_byte <= 8'b0;
		done <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
				end
			end
			START_BIT: begin
				state <= DATA_BITS;
			end
			DATA_BITS: begin
				out_byte <= {out_byte[6:0], in};
				if (out_byte == 8'b11111111) begin
					state <= STOP_BIT;
				end
			end
			STOP_BIT: begin
				if (in == 1'b1) begin
					done <= 1;
					state <= IDLE;
				end
			end
		endcase
	end
end

endmodule
