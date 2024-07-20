module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;

// State declaration
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
		done <= 0;
	end else begin
		case (state)
			BYTE1: begin
				if (in[2] == 1'b1)
					state <= BYTE2;
				end else
					state <= BYTE1;
			end
			BYTE2: state <= BYTE3;
			BYTE3: state <= DONE;
			DONE: begin
				if (in[2] == 1'b1)
					state <= BYTE2;
				end else
					state <= BYTE1;
			end
		endcase
	end
end

// Output assignment
assign done = (state == DONE);

endmodule
