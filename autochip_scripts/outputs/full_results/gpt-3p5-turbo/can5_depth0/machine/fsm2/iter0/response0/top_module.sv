module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out = 0
);
  
  reg state;
  reg next_state;
  
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
  
  always @(posedge clk) begin
    if (areset)
      state <= A;
    else
      state <= next_state;
  end
  
  always @(state) begin
    if (state == B)
      out <= 1;
    else
      out <= 0;
  end

endmodule
