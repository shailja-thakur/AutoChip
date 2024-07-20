module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

reg [2:0] state;
reg [7:0] data;

parameter IDLE = 3'b000;
parameter START = 3'b001;
parameter DATA = 3'b010;
parameter STOP = 3'b011;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= IDLE;
	else begin
		case (state)
			IDLE: begin
				if (in == 1'b0)
					state <= START;
			end
			START: begin
				state <= DATA;
			end
			DATA: begin
				state <= STOP;
				data <= {data[6:0], in};
			end
			STOP: begin
				if (in == 1'b1) begin
					state <= IDLE;
					out_byte <= data;
					done <= 1'b1;
				end
			end
		endcase
	end
end

endmodule
