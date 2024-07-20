module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

reg [2:0] state, next_state;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		state <= A;
	else
		state <= next_state;
end

always @(state or r) begin
	g <= 3'b000;

	case (state)
		A: begin
			if (r[1] && r[2] && r[3])
				next_state = A;
			else if (r[1] && !r[2] && !r[3])
				next_state = B;
			else if (!r[1] && r[2] && !r[3])
				next_state = C;
			else if (!r[1] && !r[2] && !r[3])
				next_state = D;
		end
		
		B: begin
			if (r[1])
				next_state = B;
			else
				next_state = A;
		end
		
		C: begin
			if (r[2])
				next_state = C;
			else
				next_state = A;
		end
		
		D: begin
			next_state = A;
		end
	endcase
end


always @(state) begin
	case (state)
		A: begin
			if (r[1] && !r[2] && !r[3])
				g <= 3'b001;
			else if (!r[1] && r[2] && !r[3])
				g <= 3'b010;
			else if (!r[1] && !r[2] && r[3])
				g <= 3'b100;
		end
		
		B: begin
			if (r[1] && !r[2] && !r[3])
				g <= 3'b001;
			else if (!r[1] && r[2] && !r[3])
				g <= 3'b010;
			else if (!r[1] && !r[2] && r[3])
				g <= 3'b100;
		end
		
		C: begin
			if (r[1] && r[2] && !r[3])
				g <= 3'b011;
			else if (!r[1] && r[2] && !r[3])
				g <= 3'b010;
			else if (!r[1] && !r[2] && r[3])
				g <= 3'b100;
		end
		
		D: begin
			if (r[1] && !r[2] && !r[3])
				g <= 3'b001;
			else if (!r[1] && r[2] && !r[3])
				g <= 3'b010;
			else if (!r[1] && !r[2] && r[3])
				g <= 3'b100;
		end
	endcase
end

endmodule
