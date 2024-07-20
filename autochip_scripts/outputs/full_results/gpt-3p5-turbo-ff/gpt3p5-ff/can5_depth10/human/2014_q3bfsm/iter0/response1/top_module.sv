module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] present_state;
	reg [2:0] next_state;

	always @(posedge clk or posedge reset) begin
		if(reset)
			present_state <= 3'b000;    // Reset to state 000
		else
			present_state <= next_state;    // Update present state to next state
	end

	always @(present_state or x) begin
		case(present_state)
			3'b000: begin    // Present state = 000
				if(x)
					next_state = 3'b001;    // Next state = 001 if x=1
				else
					next_state = 3'b000;    // Next state = 000 if x=0
				z = 1'b0;
			end
			3'b001: begin    // Present state = 001
				if(x)
					next_state = 3'b100;    // Next state = 100 if x=1
				else
					next_state = 3'b001;    // Next state = 001 if x=0
				z = 1'b0;
			end
			3'b010: begin    // Present state = 010
				if(x)
					next_state = 3'b001;    // Next state = 001 if x=1
				else
					next_state = 3'b010;    // Next state = 010 if x=0
				z = 1'b0;
			end
			3'b011: begin    // Present state = 011
				if(x)
					next_state = 3'b010;    // Next state = 010 if x=1
				else
					next_state = 3'b001;    // Next state = 001 if x=0
				z = 1'b1;
			end
			3'b100: begin    // Present state = 100
				if(x)
					next_state = 3'b100;    // Next state = 100 if x=1
				else
					next_state = 3'b011;    // Next state = 011 if x=0
				z = 1'b1;
			end
		endcase
	end

endmodule
