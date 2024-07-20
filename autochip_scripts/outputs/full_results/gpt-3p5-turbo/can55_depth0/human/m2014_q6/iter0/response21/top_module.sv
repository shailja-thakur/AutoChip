module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Define state and next_state
	reg [1:0] state;
	reg [1:0] next_state;
	
	// Define combinational logic
	always @(*) begin
		case (state)
			A: begin
				if (w)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if (w)
					next_state = D;
				else
					next_state = C;
			end
			C: begin
				if (w)
					next_state = D;
				else
					next_state = E;
			end
			D: begin
				if (w)
					next_state = A;
				else
					next_state = F;
			end
			E: begin
				if (w)
					next_state = D;
				else
					next_state = E;
			end
			F: begin
				if (w)
					next_state = D;
				else
					next_state = C;
			end
			default: next_state = A;
		endcase
	end
	
	// Define sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Define output behavior
	always @(state) begin
		case (state)
			A: z = 0;
			B: z = 0;
			C: z = 0;
			D: z = 0;
			E: z = 1;
			F: z = 1;
			default: z = 0;
		endcase
	end
	
endmodule
