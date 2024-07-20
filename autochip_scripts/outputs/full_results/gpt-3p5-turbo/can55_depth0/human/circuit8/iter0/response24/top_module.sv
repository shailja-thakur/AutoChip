module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);
    
  reg p_reg, q_reg;
  
  always @(posedge clock) begin
    if(a == 1'b1) begin
      p_reg <= 1'b1;
      q_reg <= 1'b0;
    end
    else begin
      p_reg <= p_reg;
      q_reg <= p_reg & q_reg;
    end
  end
  
  always @(posedge clock) begin
    if(a == 1'b1) begin
      p <= 1'b1;
      q <= 1'b0;
    end
    else begin
      p <= p;
      q <= p & q;
    end
  end
  
endmodule
