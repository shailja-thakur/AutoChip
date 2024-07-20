module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

// Define states
parameter WAIT_START = 2'b00;
parameter PROCESS_DATA = 2'b01;
parameter WAIT_STOP = 2'b10;

reg [1:0] state;
reg [7:0] data_byte;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= WAIT_START;
		data_byte <= 8'b0;
		done <= 0;
	end else begin
		case (state)
			WAIT_START: begin
				if (in == 1'b0) begin
					state <= PROCESS_DATA;
				end
			end
			PROCESS_DATA: begin
				data_byte <= {in, data_byte[7:1]};
				state <= (data_byte == 8'b0) ? PROCESS_DATA : WAIT_STOP;
			end
			WAIT_STOP: begin
				if (in == 1'b1) begin
					state <= WAIT_START;
					done <= 1;
				end
			end
		endcase
	end
end

assign out_byte = done ? data_byte : 8'bzzzzzzzz;
endmodule
