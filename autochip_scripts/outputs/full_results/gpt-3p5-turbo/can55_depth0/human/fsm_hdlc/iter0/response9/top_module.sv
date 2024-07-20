module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	parameter START = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
  
	reg [1:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= START;
		else
			state <= next_state;
	end

	always @(state or in) begin
		case(state)
			START: begin
				if (in == 1)
					next_state = S1;
				else 
					next_state = START;
			end
			S1: begin
				if (in == 1)
					next_state = S2;
				else 
					next_state = START;
			end
			S2: begin
				if (in == 1)
					next_state = err;
				else 
					next_state = flag;
			end
			err: begin
				if (in == 1)
					next_state = err;
				else 
					next_state = START;
			end
			flag: begin
				if (in == 1)
					next_state = S1;
				else 
					next_state = disc;
			end
			disc: begin
				if (in == 1)
					next_state = S1;
				else 
					next_state = START;
			end
		endcase
	end

	assign disc = (state == disc);
	assign flag = (state == flag);
	assign err = (state == err);
  
endmodule
