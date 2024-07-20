module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define the states as constants
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;

// Declare the state register
reg [1:0] state;
reg out;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		case (state)
			A: begin
				if (in) begin
					state <= B;
				end else begin
					state <= A;
				end
			end
			B: begin
				if (in) begin
					state <= B;
				end else begin
					state <= C;
				end
			end
			C: begin
				if (in) begin
					state <= D;
				end else begin
					state <= A;
				end
			end
			D: begin
				if (in) begin
					state <= B;
				end else begin
					state <= C;
				end
			end
		endcase
	end
end

// Assign output based on the current state
always @(state) begin
	if (state == D) begin
		out = 1;
	end else begin
		out = 0;
	end
end

endmodule
