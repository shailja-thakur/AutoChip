module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] data;
reg stop_bit;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		data <= 8'b0;
		stop_bit <= 1'b0;
		done <= 1'b0;
	end
	else begin
		case (state)
			IDLE: begin
				if (in == 1'b0)
					state <= START_BIT;
				else
					state <= IDLE;
			end

			START_BIT: begin
				state <= DATA_BITS;
			end

			DATA_BITS: begin
				data <= {data[6:0], in};
				if (data == 8'b11111110)
					state <= START_BIT;
				else if (data == 8'b11111111)
					state <= STOP_BIT;
				else
					state <= DATA_BITS;
			end

			STOP_BIT: begin
				if (in == 1'b1)
					state <= IDLE;
				else
					state <= STOP_BIT;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == STOP_BIT && in == 1'b1)
		done <= 1'b1;
	else
		done <= 1'b0;
end

endmodule
