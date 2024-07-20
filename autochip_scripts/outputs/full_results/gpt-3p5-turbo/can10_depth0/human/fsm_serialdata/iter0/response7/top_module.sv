module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	parameter IDLE         = 2'b00;
	parameter START_BIT    = 2'b01;
	parameter RECEIVE_DATA = 2'b10;
	parameter STOP_BIT     = 2'b11;

	reg [1:0] state;
	reg [7:0] data;
	reg [2:0] count;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else begin
			case(state)
				IDLE: begin
					if (!in)
						state <= START_BIT;
					else
						state <= IDLE;
				end
				START_BIT: begin
					state <= RECEIVE_DATA;
				end
				RECEIVE_DATA: begin
					count <= count + 1;
					data[count] <= in;
					if (count == 7)
						state <= STOP_BIT;
				end
				STOP_BIT: begin
					if (in)
						state <= IDLE;
					else
						state <= START_BIT;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == IDLE)
			count <= 0;
	end

	always @(posedge clk) begin
		if (state == STOP_BIT) begin
			out_byte <= data;
			done <= 1;
		end else
			done <= 0;
	end

endmodule
