module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] data_bits;

parameter START_BIT = 3'b000;
parameter WAIT_BITS = 3'b001;
parameter WAIT_STOP_BIT = 3'b010;

always @(posedge clk) begin
	if (reset) begin
		state <= START_BIT;
		data_bits <= 8'b0;
	end else begin
		case (state)
			START_BIT:
				if (in == 1'b0) begin
					state <= WAIT_BITS;
					data_bits <= 8'b0;
					done <= 0;
				end else begin
					state <= START_BIT;
					done <= 0;
				end
			WAIT_BITS:
				begin
					data_bits <= {data_bits[6:0], in};
					state <= (data_bits == 8'b11111111) ? WAIT_STOP_BIT : WAIT_BITS;
					done <= 0;
				end
			WAIT_STOP_BIT:
				if (in == 1'b1) begin
					state <= START_BIT;
					done <= 1;
				end else begin
					state <= WAIT_STOP_BIT;
					done <= 0;
				end
		endcase
	end
end

endmodule
