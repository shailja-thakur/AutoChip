module top_module (
  input clk,
  input a,
  input b,
  output reg q,
  output reg state
);

reg q_next;
reg state_next;

always @(posedge clk) begin
  q <= q_next;
  state <= state_next;
end

always @(a or b) begin
  if(a == 1'b1 & b == 1'b0)
    state_next = 1'b0;
  else if(a == 1'b0 & b == 1'b1)
    state_next = 1'b0;
  else if(a == 1'b0 & b == 1'b0)
    state_next = 1'b0;
  else if(a == 1'b1 & b == 1'b1)
    state_next = 1'b1;
end

initial begin
  q = 1'b0;
  state = 1'b0;
end

always @(*) begin
  case(state)
    1'b0: begin
      q_next = a;
    end
    1'b1: begin
      q_next = 1'b1;
    end
  endcase
end

endmodule
