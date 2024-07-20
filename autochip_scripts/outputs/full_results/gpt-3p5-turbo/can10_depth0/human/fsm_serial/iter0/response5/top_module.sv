module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg start_bit;
reg [7:0] data_bits;
reg stop_bit;

// State definitions
parameter START = 3'b000;
parameter RECEIVE = 3'b001;
parameter VERIFY_STOP = 3'b010;
parameter NEXT = 3'b011;

// Next state logic
always @(posedge clk) begin
	if (reset) begin
		state <= START;
		start_bit <= 0;
		data_bits <= 0;
		stop_bit <= 0;
	end else begin
		case (state)
			START: begin
				if (in) begin
					state <= RECEIVE;
					start_bit <= 1;
					data_bits <= 0;
				end else begin
					state <= START;
				end
			end
			RECEIVE: begin
				if (in) begin
					data_bits <= {data_bits[6:0], in};
				end else begin
					state <= VERIFY_STOP;
				end
			end
			VERIFY_STOP: begin
				if (in) begin
					stop_bit <= in;
					if (stop_bit) begin
						state <= NEXT;
					end else begin
						state <= VERIFY_STOP;
					end
				end else begin
					state <= VERIFY_STOP;
				end
			end
			NEXT: begin
				state <= START;
			end
		endcase
	end
end

// Output logic
assign done = (state == NEXT);

endmodule
