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

reg data_valid;
reg [7:0] received_data;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		data_valid <= 0;
		received_data <= 0;
		state <= IDLE;
	end else begin
		case (state)
			IDLE: begin
				if (in == 1'b0)
					state <= START_BIT;
			end
			START_BIT: begin
				if (in == 1'b0)
					state <= DATA_BITS;
				else
					state <= IDLE;
			end
			DATA_BITS: begin
				received_data <= {received_data[6:0], in};
				if (received_data == 8'b11111110)
					state <= STOP_BIT;
			end
			STOP_BIT: begin
				if (in == 1'b1) begin
					data_valid <= 1;
					state <= IDLE;
				end
			end
		endcase
	end
end

assign done = data_valid;

endmodule
