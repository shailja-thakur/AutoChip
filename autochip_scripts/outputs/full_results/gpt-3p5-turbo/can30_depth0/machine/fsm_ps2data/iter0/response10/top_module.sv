module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

// Define the states
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Define the signals
reg [1:0] state;
reg [23:0] register;
reg done;

// State machine logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
		register <= 0;
		done <= 0;
	end else begin
		case (state)
			BYTE1: begin
				if (in[3] == 1'b1)
					state <= BYTE2;
				else
					state <= BYTE1;
					register <= register;
			end
			
			BYTE2: begin
				state <= BYTE3;
				register <= register;
			end
			
			BYTE3: begin
				state <= DONE;
				register <= register;
			end
			
			DONE: begin
				if (in[3] == 1'b0)
					state <= BYTE1;
				else
					state <= DONE;
					register <= register;
			end
		endcase
	end
end

// Output logic
always @(posedge clk) begin
	if (state == DONE)
		done <= 1'b1;
	
	if (done)
		out_bytes <= register;
end

endmodule
