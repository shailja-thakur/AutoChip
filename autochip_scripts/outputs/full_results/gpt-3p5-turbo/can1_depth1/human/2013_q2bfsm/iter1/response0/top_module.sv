module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

reg [1:0] state, next_state;
reg [2:0] x_sequence;
reg y_detected;
wire reset = ~resetn;

// State definitions
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;

// Sequential logic
always @(posedge clk or negedge reset) begin
	if (~reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// Next state logic
always @(state, x, y) begin
	case (state)
		A: begin
			f <= 0;
			g <= 0;
			x_sequence <= {x_sequence[1:0], x};
			if (x_sequence == 3'b101) begin
				next_state <= B;
			end else begin
				next_state <= A;
			end
		end
		B: begin
			f <= 1;
			next_state <= C;
		end
		C: begin
			if (y == 1) begin
				g <= 1;
				if (x_sequence != 3'b101) begin
					next_state <= D;
				end else begin
					next_state <= C;
				end
			end else begin
				g <= 0;
				next_state <= A;
			end
		end
		D: begin
			g <= 1;
			next_state <= D;
		end
	endcase
end

endmodule
