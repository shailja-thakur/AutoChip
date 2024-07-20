module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

localparam [1:0] 
	A = 2'b00,
	B = 2'b01;

reg [1:0] state, next_state;

always @(*) begin
	case (state)
		A: begin
			if (in == 1'b0) begin
				next_state = B;
				out = 1'b0;
			end else begin
				next_state = A;
				out = 1'b0;
			end
		end
		B: begin
			if (in == 1'b0) begin
				next_state = B;
				out = 1'b1;
			end else begin
				next_state = A;
				out = 1'b1;
			end
		end
		default: begin
			next_state = B;
			out = 1'b0;
		end
	endcase
end

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= B;
	end else begin
		state <= next_state;
	end
end

endmodule
