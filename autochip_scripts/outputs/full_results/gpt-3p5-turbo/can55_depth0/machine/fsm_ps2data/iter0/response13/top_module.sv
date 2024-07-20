module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	// Define states for the state machine
	reg [1:0] state;
	parameter BYTE1 = 2'b00;
	parameter BYTE2 = 2'b01;
	parameter BYTE3 = 2'b10;
	parameter DONE = 2'b11;
	
	// Define temporary variables for next state logic
	reg [2:0] next_state;
	reg [7:0] next_out_bytes;
	
	// Define register for storing current state
	reg [1:0] current_state;
	reg [7:0] shift_register;
	
	// Update current state on positive edge of clk
	always @(posedge clk) begin
		if (reset) begin
			current_state <= BYTE1;
			shift_register <= 8'b0;
		end else begin
			current_state <= next_state;
			shift_register <= {shift_register[15:0], in};
		end
	end
	
	// Next state logic
	always @(*) begin
		case (current_state)
			BYTE1: begin
				if (in[2] == 1'b1)
					next_state = BYTE2;
				else
					next_state = BYTE1;
			end
			BYTE2: begin
				next_state = BYTE3;
			end
			BYTE3: begin
				next_state = DONE;
			end
			DONE: begin
				if (in[2] == 1'b0)
					next_state = BYTE1;
				else
					next_state = DONE;
			end
		endcase
	end
	
	// Update out_bytes and done signal based on current state
	always @(*) begin
		case (current_state)
			BYTE1: begin
				next_out_bytes = shift_register;
				done = 1'b0;
			end
			BYTE2, BYTE3: begin
				next_out_bytes = out_bytes;
				done = 1'b0;
			end
			DONE: begin
				next_out_bytes = shift_register;
				done = 1'b1;
			end
		endcase
	end
	
	// Update out_bytes on positive edge of clk
	always @(posedge clk) begin
		out_bytes <= next_out_bytes;
	end
	
endmodule
