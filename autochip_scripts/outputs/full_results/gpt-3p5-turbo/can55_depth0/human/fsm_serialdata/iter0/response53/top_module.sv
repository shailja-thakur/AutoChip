module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

// State declaration
parameter IDLE = 2'b00;
parameter RECEIVE_START_BIT = 2'b01;
parameter RECEIVE_DATA_BITS = 2'b10;
parameter RECEIVE_STOP_BIT = 2'b11;

// State register
reg [1:0] state;

// Temporary variables
reg [7:0] data_byte;

// Output register
reg [7:0] out_byte_reg;

// State transition logic
always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		data_byte <= 8'b0;
		out_byte_reg <= 8'b0;
	end else begin
		case (state)
			IDLE:
				if (in == 1'b0) begin
					state <= RECEIVE_START_BIT;
				end
			RECEIVE_START_BIT:
				state <= RECEIVE_DATA_BITS;
			RECEIVE_DATA_BITS:
				if (in == 1'b0) begin
					data_byte <= {in, data_byte[7:1]};
				end else begin
					state <= RECEIVE_STOP_BIT;
				end
			RECEIVE_STOP_BIT:
				if (in == 1'b1) begin
					out_byte_reg <= data_byte;
					state <= IDLE;
				end
		endcase
	end
end

// Output assignment
assign out_byte = out_byte_reg;
assign done = (state == RECEIVE_STOP_BIT);

endmodule
