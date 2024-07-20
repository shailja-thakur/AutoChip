module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [3:0] state;

parameter IDLE = 4'b0000;
parameter START_BIT = 4'b0001;
parameter DATA_BITS = 4'b0010;
parameter STOP_BIT = 4'b0011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
	end else begin
		case(state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
				end else begin
					state <= IDLE;
				end
			end
			START_BIT: begin
				if (in == 1'b0) begin
					state <= DATA_BITS;
				end else begin
					state <= IDLE;
				end
			end
			DATA_BITS: begin
				if (in == 1'b0) begin
					state <= DATA_BITS;
				end else begin
					state <= STOP_BIT;
				end
			end
			STOP_BIT: begin
				if (in == 1'b1) begin
					state <= IDLE;
				end else begin
					state <= IDLE;
				end
			end
		endcase
	end
end

assign done = (state == IDLE);

endmodule
