module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

// State definition
reg [1:0] state;

// State values
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// State machine logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
		done <= 0;
	end else begin
		case(state)
			BYTE1: begin
				if (in[2] == 1'b1)
					state <= BYTE2;
				else
					state <= BYTE1;
			end
			
			BYTE2: begin
				state <= BYTE3;
			end
			
			BYTE3: begin
				state <= DONE;
			end
			
			DONE: begin
				if (in[2] == 1'b1)
					state <= BYTE2;
				else
					state <= BYTE1;
			end
		endcase
	end
end

// Output logic
always @(state) begin
	done = (state == DONE);
end

endmodule
