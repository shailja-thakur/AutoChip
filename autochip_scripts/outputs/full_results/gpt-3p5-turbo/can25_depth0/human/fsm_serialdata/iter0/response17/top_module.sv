module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

// States
parameter IDLE = 2'b00;
parameter START_BIT = 2'b01;
parameter DATA_BITS = 2'b10;
parameter STOP_BIT = 2'b11;

// Internal signals
reg [1:0] state;
reg [7:0] data_byte;

// Output signals
assign out_byte = data_byte;

// FSM
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		data_byte <= 8'b0;
	end else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
					data_byte <= 8'b0;
				end
			end
			START_BIT: begin
				state <= DATA_BITS;
				data_byte <= 8'b0;
			end
			DATA_BITS: begin
				data_byte <= {data_byte[6:0], in};
				if (data_byte == 8'b11111111) begin
					state <= STOP_BIT;
				end
			end
			STOP_BIT: begin
				if (in == 1'b1) begin
					state <= IDLE;
					done <= 1;
				end
			end
		endcase
	end
end

endmodule
