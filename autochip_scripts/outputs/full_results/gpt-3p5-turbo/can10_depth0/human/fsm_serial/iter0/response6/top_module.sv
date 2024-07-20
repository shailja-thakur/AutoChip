module top_module (
	input clk,
	input in,
	input reset,
	output done
);

// internal signals
reg [2:0] state;
reg start_bit;
reg [7:0] data;
reg stop_bit;

// FSM states
parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;

// FSM
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		start_bit <= 0;
		data <= 0;
		stop_bit <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (in == 1) begin
					state <= START_BIT;
				end
			end

			START_BIT: begin
				if (in == 0) begin
					state <= DATA_BITS;
					data <= 0;
				end
			end

			DATA_BITS: begin
				if (in == 0) begin
					data <= {data[6:0], in};
				end else begin
					state <= STOP_BIT;
				end
			end

			STOP_BIT: begin
				if (in == 1) begin
					state <= IDLE;
					stop_bit <= 1;
				end
			end
		endcase
	end
end

// output done signal
assign done = (state == IDLE && stop_bit == 1);

endmodule
