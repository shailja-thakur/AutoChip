module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

parameter A = 0;
parameter B = 1;

reg [1:0] state;
always @(posedge clk)
begin
	 if(reset)
	 begin
		 state <= B;
	 end
	 else
	 begin
		 case(state)
			A: state <= (in) ? A : B;
			B: state <= (in) ? B : A;
		 endcase
	 end
end

assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
