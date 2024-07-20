module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

// Define state codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state, next_state;

// State flip-flop
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// State table
always @(state or r) begin
	case (state)
		A: begin
			if (r[1] == 1) begin
				next_state = B;
			end else if (r[2] == 1) begin
				next_state = C;
			end else begin
				next_state = A;
			end
		end
		B: begin
			if (r[1] == 1 && g[1] == 1) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		C: begin
			if (r[2] == 1 && g[2] == 1) begin
				next_state = C;
			end else begin
				next_state = A;
			end
		end
		default: next_state = A;
	endcase
end

// Continuous assignment for outputs
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		g <= 0;
	end else begin
		case (state)
			A: g <= 3'b000;
			B: g <= 3'b001;
			C: g <= 3'b010;
			default: g <= 3'b000;
		endcase
	end
end

endmodule
