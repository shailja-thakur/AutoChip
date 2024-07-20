module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [3:0] state;
reg [2:0] count;
reg last_bit;

parameter IDLE = 0;
parameter START_BIT = 1;
parameter DATA_BITS = 2;
parameter STOP_BIT = 3;

always@(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		count <= 0;
		last_bit <= 0;
	end
	else begin
		case(state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
					count <= 1;
					last_bit <= 0;
				end
			end
			
			START_BIT: begin
				if (count < 8) begin
					count <= count + 1;
					last_bit <= in;
					state <= DATA_BITS;
				end
				else if (count == 8) begin
					last_bit <= 0;
					state <= STOP_BIT;
				end
			end
			
			DATA_BITS: begin
				if (count < 8) begin
					count <= count + 1;
					last_bit <= in;
				end
				else if (count == 8) begin
					last_bit <= 0;
					state <= STOP_BIT;
				end
			end
			
			STOP_BIT: begin
				if (in == 1'b1 && last_bit == 1'b0) begin
					state <= IDLE;
					count <= 0;
				end
			end
		endcase
	end
end

assign done = (state == IDLE) ? 1'b1 : 1'b0;

endmodule
