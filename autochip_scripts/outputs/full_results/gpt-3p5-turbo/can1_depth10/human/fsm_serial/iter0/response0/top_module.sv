module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;

parameter START = 3'b000;
parameter IN_PROGRESS = 3'b001;
parameter VERIFY_STOP_BIT = 3'b010;
parameter BYTE_RECEIVED = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= START;
	end else begin
		case (state)
			START:
				if (in == 1'b0) begin
					state <= IN_PROGRESS;
				end else begin
					state <= START;
				end
			IN_PROGRESS:
				if (in == 1'b0) begin
					state <= IN_PROGRESS;
				end else begin
					state <= VERIFY_STOP_BIT;
				end
			VERIFY_STOP_BIT:
				if (in == 1'b1) begin
					state <= BYTE_RECEIVED;
				end else begin
					state <= START;
				end
			BYTE_RECEIVED:
				state <= START;
		endcase
	end
end

assign done = (state == BYTE_RECEIVED);

endmodule
