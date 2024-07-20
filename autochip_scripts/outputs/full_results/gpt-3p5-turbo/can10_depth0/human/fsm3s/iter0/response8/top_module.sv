module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [3:0] state;
wire [1:0] next_state;
reg out;

parameter A = 4'b0000;
parameter B = 4'b0001;
parameter C = 4'b0010;
parameter D = 4'b0011;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
		out <= 0;
	end else begin
		state <= next_state;
		out <= (state == D) ? 1'b1 : 1'b0;
	end
end

always @(state, in) begin
	case (state)
		A: begin
			next_state = (in == 1'b0) ? B : A;
		end
		B: begin
			next_state = (in == 1'b0) ? C : B;
		end
		C: begin
			next_state = (in == 1'b0) ? A : D;
		end
		D: begin
			next_state = (in == 1'b0) ? C : B;
		end
	endcase
end

endmodule
