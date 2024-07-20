module top_module (
  input clk,
  input a,
  input b,
  output q,
  output state
);

  reg q_reg;
  reg state_reg;
  
  always @(posedge clk) begin
    state_reg <= state_reg;
    
    case({a,b})
      2'b00: q_reg <= q_reg;
      2'b01: q_reg <= q_reg;
      2'b10: q_reg <= ~q_reg;
      2'b11: q_reg <= ~q_reg;
    endcase
  end
  
  assign state = state_reg;
  assign q = q_reg;
  
endmodule
