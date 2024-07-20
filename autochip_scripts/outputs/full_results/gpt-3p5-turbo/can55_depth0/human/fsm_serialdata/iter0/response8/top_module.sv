module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] data;
reg [7:0] shift_reg;

// Define states
parameter IDLE = 0;
parameter START = 1;
parameter DATA = 2;
parameter STOP = 3;

// Define constants
parameter START_BIT = 1'b0;
parameter STOP_BIT = 1'b1;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		data <= 8'b0;
		shift_reg <= 8'b0;
	else if (state == IDLE) begin
		if (in == START_BIT) begin
			shift_reg <= 8'b0;
			state <= START;
		end
	else if (state == START) begin
		shift_reg <= {shift_reg[6:0], in};
		state <= DATA;
	else if (state == DATA) begin
		shift_reg <= {shift_reg[6:0], in};
		if (shift_reg[7] == STOP_BIT) begin
			state <= STOP;
		else begin
			data <= shift_reg;
			state <= DATA;
		end
	else if (state == STOP) begin
		if (in == STOP_BIT) begin
			data <= shift_reg;
			state <= IDLE;
		end
		else begin
			state <= STOP;
		end
	end
end

assign out_byte = data;
assign done = (state == STOP);

endmodule
