module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

parameter A = 2'b00;
parameter B = 2'b01;

reg [1:0] state;
reg x_prev;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= A;
	end else begin
		case (state)
			A: begin
				if (x == 1'b1) begin
					state <= B;
				end else begin
					state <= A;
				end
			end
			B: begin
				state <= B;
			end
		endcase
	end
end

always @(posedge clk) begin
	x_prev <= x;
	if ((state == A && x_prev == 1'b1) || (state == B && x_prev == 1'b0)) begin
		z <= 1'b1;
	end else begin
		z <= 1'b0;
	end
end

endmodule
