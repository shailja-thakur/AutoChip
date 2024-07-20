module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Assign initial state
reg [1:0] state, next_state;
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// Define state transitions
always @(*) begin
	case (state)
		A: begin
			if (r[1] && r[2] && r[3]) begin
				next_state = A;
			end else if (r[1]) begin
				next_state = B;
			end else if (r[2]) begin
				next_state = C;
			end else if (r[1] && r[2] && r[3]) begin
				next_state = D;
			end
		end
		B: begin
			if (r[1] && g[1]) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		C: begin
			if (r[2] && g[2]) begin
				next_state = C;
			end else begin
				next_state = A;
			end
		end
		D: begin
			next_state = A;
		end
	endcase
end

// Assign outputs
always @(*) begin
	case (state)
		A: begin
			g[1] = 1'b0;
			g[2] = 1'b0;
			g[3] = 1'b0;
		end
		B: begin
			g[1] = 1'b1;
			g[2] = 1'b0;
			g[3] = 1'b0;
		end
		C: begin
			g[1] = 1'b0;
			g[2] = 1'b1;
			g[3] = 1'b0;
		end
		D: begin
			g[1] = 1'b0;
			g[2] = 1'b0;
			g[3] = 1'b0;
		end
	endcase
end

endmodule
