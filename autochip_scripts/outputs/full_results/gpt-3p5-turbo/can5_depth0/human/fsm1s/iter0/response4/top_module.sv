module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg out;
reg [1:0] state;
reg [1:0] next_state;

parameter B = 2'b00;
parameter A = 2'b01;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= B;
		out <= 1;
	end else begin
		state <= next_state;
		out <= (state == A) ? 0 : 1;
	end
end

always @* begin
	case(state)
		B: begin
			if(in == 0)
				next_state = A;
			else
				next_state = B;
		end
		A: begin
			if(in == 0)
				next_state = B;
			else
				next_state = A;
		end
	endcase
end

endmodule
