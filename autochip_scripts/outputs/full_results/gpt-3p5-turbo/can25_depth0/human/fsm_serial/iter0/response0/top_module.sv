module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [3:0] state;
reg start_bit, stop_bit;
reg [7:0] data_bits;
reg [2:0] count;

parameter IDLE = 0, RECEIVE = 1;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= IDLE;
	else
		case (state)
			IDLE: begin
				if (in == 1'b0)
					state <= RECEIVE;
			end
			RECEIVE: begin
				if (count == 2) begin
					if (in == 1'b1)
						stop_bit <= 1'b1;
					else
						stop_bit <= 1'b0;
					state <= IDLE;
				end else begin
					if (count == 0) begin
						start_bit <= in;
						data_bits <= 0;
					end else begin
						data_bits <= {in, data_bits[7:1]};
					end
					count <= count + 1'b1;
				end
			end
		endcase
end

assign done = (state == IDLE);

endmodule
