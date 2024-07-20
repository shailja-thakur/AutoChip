module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state, next_state;
reg out_reg;

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the output values
parameter OUTPUT_A = 1'b0;
parameter OUTPUT_BCD = 1'b1;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case(state)
		A: begin
			if (in) begin
				next_state = B;
			end else begin
				next_state = A;
			end
			out_reg = OUTPUT_A;
		end
		
		B: begin
			if (in) begin
				next_state = B;
			end else begin
				next_state = C;
			end
			out_reg = OUTPUT_A;
		end
		
		C: begin
			if (in) begin
				next_state = D;
			end else begin
				next_state = A;
			end
			out_reg = OUTPUT_A;
		end
		
		D: begin
			if (in) begin
				next_state = B;
			end else begin
				next_state = C;
			end
			out_reg = OUTPUT_BCD;
		end
	endcase
end

assign out = out_reg;

endmodule
