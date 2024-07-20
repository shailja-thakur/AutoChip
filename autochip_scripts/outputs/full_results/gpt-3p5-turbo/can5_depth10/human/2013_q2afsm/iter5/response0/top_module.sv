module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// Define state codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state, next_state;
reg [3:1] g_next;

// State flip-flop
always @(posedge clk or negedge resetn) begin
	if (resetn == 0) begin
		state <= A;
        g_next <= 3'b000;
	end else begin
		state <= next_state;
        g_next <= g;
	end
end

// State table
always @(state or r) begin
	case (state)
		A: begin
			if (r[1] == 0 && r[2] == 0 && r[3] == 0) begin
				next_state = A;
			end else if (r[1] == 1) begin
				next_state = B;
			end else if (r[2] == 1) begin
				next_state = C;
			end else begin
				next_state = D;
			end
		end
		B: begin
			if (r[1] == 1 && g[1] == 1) begin
				next_state = B;
			end else if (r[1] == 0) begin
				next_state = A;
			end else begin
				next_state = B;
			end
		end
		C: begin
			if (r[2] == 1 && g[2] == 1) begin
				next_state = C;
			end else if (r[2] == 0) begin
				next_state = A;
			end else begin
				next_state = C;
			end
		end
		default: next_state = A;
	endcase
end

// Continuous assignment for outputs
always @(posedge clk) begin
    g <= g_next;
end

endmodule
