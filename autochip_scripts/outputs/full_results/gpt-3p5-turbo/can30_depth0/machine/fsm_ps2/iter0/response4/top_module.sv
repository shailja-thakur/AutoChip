module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;

// State definitions
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Transition and next-state logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
	end else begin
		case(state)
			BYTE1: begin
				if (in[2] == 1'b1) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end
			BYTE2: begin
				state <= BYTE3;
			end
			BYTE3: begin
				state <= DONE;
			end
			DONE: begin
				if (in[2] == 1'b1) begin
					state <= BYTE2;
				end else begin
					state <= BYTE1;
				end
			end
		endcase
	end
end

// Output logic
always @(state) begin
	if (state == DONE) begin
		done = 1'b1;
	end else begin
		done = 1'b0;
	end
end

endmodule
