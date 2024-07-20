module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= A;
  else
    state <= next_state;
end

always @* begin
  case (state)
    A: begin
      if (j)
        next_state = B;
      else
        next_state = A;
    end
    B: begin
      if (k)
        next_state = A;
      else
        next_state = B;
    end
  endcase
end

always @(state) begin
  if (state == B)
    out = 1'b1;
  else
    out = 1'b0;
end

endmodule
