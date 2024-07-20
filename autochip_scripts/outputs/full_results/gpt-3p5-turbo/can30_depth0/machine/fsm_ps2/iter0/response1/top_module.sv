module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;

// State assignments
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Next state logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
		done <= 0;
	end else begin
		case (state)
			BYTE1: begin
				if (in[2] == 1)
					state <= BYTE2;
			end
			BYTE2: begin
				state <= BYTE3;
			end
			BYTE3: begin
				state <= DONE;
			end
			DONE: begin
				if (in[2] == 0)
					state <= BYTE1;
				else
					state <= BYTE2;
			end
		endcase
	end
end

// Output assignment
always @(state, in) begin
	done <= (state == DONE);
end

endmodule
