module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state, next_state;
wire grant;

// Define the states
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

// State table
always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// State flip-flops
always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		next_state <= A;
	end else begin
		case (state)
			A: begin
				if (r[1] && !r[2] && !r[3])
					next_state <= B;
				else if (!r[1] && r[2] && !r[3])
					next_state <= C;
				else if (!r[1] && !r[2] && !r[3])
					next_state <= D;
				else
					next_state <= A;
			end
			B: begin
				if (r[1])
					next_state <= B;
				else
					next_state <= A;
			end
			C: begin
				if (r[2])
					next_state <= C;
				else
					next_state <= A;
			end
			default: next_state <= A;
		endcase
	end
end

// Outputs
assign g[1] = (state == B);
assign g[2] = (state == C);
assign g[3] = (state == A && !r[1] && !r[2] && r[3]);

endmodule
