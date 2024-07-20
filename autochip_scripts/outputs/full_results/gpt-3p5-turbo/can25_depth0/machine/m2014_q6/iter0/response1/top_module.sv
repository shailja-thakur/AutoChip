module top_module (
	input wire clk,
	input wire reset,
	input wire w,
	output wire z
);

// Define the states using parameters
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

// Define the state and next_state variables
reg [2:0] state;
reg [2:0] next_state;

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
			if (w == 1'b0) begin
				next_state = B;
			end else begin
				next_state = A;
			end
		end
		B: begin
			if (w == 1'b1) begin
				next_state = D;
			end else begin
				next_state = C;
			end
		end
		C: begin
			if (w == 1'b1) begin
				next_state = D;
			end else begin
				next_state = E;
			end
		end
		D: begin
			if (w == 1'b1) begin
				next_state = A;
			end else begin
				next_state = F;
			end
		end
		E: begin
			if (w == 1'b1) begin
				next_state = D;
			end else begin
				next_state = E;
			end
		end
		F: begin
			if (w == 1'b1) begin
				next_state = D;
			end else begin
				next_state = C;
			end
		end
	endcase
end

assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
