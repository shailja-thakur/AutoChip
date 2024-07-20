module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state, next_state;
reg [3:1] gout;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

initial begin
	state = A;
	next_state = A;
end

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case(state)
		A: begin
			if (r[1] & r[2] & r[3])begin
				gout = 3'b000;
				next_state = A;
			end else if (!r[1] & !r[2] & !r[3]) begin
				gout = 3'b000;
				next_state = D;
			end else if (r[1]) begin
				gout = 3'b100;
				next_state = B;
			end else if (!r[1] & r[2]) begin
				gout = 3'b010;
				next_state = C;
			end
		end
		
		B: begin
			if (r[1]) begin
				gout = 3'b100;
				next_state = B;
			end else begin
				gout = 3'b000;
				next_state = A;
			end
		end
		
		C: begin
			if (r[2]) begin
				gout = 3'b010;
				next_state = C;
			end else begin
				gout = 3'b000;
				next_state = A;
			end
		end
		
		D: begin
			if (r[1] & r[2] & r[3])begin
				gout = 3'b000;
				next_state = A;
			end
		end
	endcase
end

assign g = gout;

endmodule
