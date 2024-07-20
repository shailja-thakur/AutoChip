module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	parameter IDLE = 2'b00;
	parameter START_BIT = 2'b01;
	parameter DATA_BITS = 2'b10;
	parameter STOP_BIT = 2'b11;
	reg [1:0] state;
	reg done;
	reg [7:0] data;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else begin
			case (state)
				IDLE:
					if (in == 1'b0)
						state <= START_BIT;
					else
						state <= IDLE;
				START_BIT:
					begin
						data <= 8'b0;
						state <= DATA_BITS;
					end
				DATA_BITS:
					begin
						data <= {data[6:0], in};
						state <= (data == 8'b11111111) ? STOP_BIT : DATA_BITS;
					end
				STOP_BIT:
					if (in == 1'b1) begin
						done <= 1'b1;
						state <= IDLE;
					end else
						state <= STOP_BIT;
			endcase
		end
	end

endmodule
