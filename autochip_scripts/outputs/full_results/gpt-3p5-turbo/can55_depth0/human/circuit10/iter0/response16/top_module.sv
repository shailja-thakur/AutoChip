module top_module (
  input clk,
  input a,
  input b,
  output q,
  output state
);
  
  reg q;
  reg state;
  reg q_next;
  
  always @(posedge clk) begin
    q <= q_next;
    state <= q;
  end
  
  always @(a, b, state) begin
    case (state)
      0 :
        if (a & ~b)
          q_next = 0;
        else
          q_next = q;
      1 :
        if (~a & b)
          q_next = 1;
        else
          q_next = q;
      default :
        q_next = q;
    endcase
  end
  
endmodule
