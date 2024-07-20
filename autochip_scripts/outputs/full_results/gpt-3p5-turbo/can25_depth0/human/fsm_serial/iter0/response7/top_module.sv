module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;
parameter ERROR_STOP = 3'b100;

reg start_detected;
reg [7:0] data_byte;
reg stop_detected;

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
				state <= DATA_BITS;
			DATA_BITS:
				if (start_detected) begin
					data_byte <= {data_byte[6:0], in};
					if (start_detected == 8)
						state <= STOP_BIT;
				end
				else
					state <= DATA_BITS;
			STOP_BIT:
				if (in == 1'b1)
					state <= IDLE;
				else
					state <= ERROR_STOP;
			ERROR_STOP:
				if (in == 1'b1)
					state <= IDLE;
				else
					state <= ERROR_STOP;
			default:
				state <= IDLE;
		endcase
	end
end

always @(posedge clk) begin
	if (reset)
		start_detected <= 0;
	else begin
		case (state)
			START_BIT:
				start_detected <= 1;
			STOP_BIT:
				stop_detected <= 1;
			ERROR_STOP, IDLE:
				stop_detected <= 0;
		endcase
	end
end

assign done = stop_detected;

endmodule
