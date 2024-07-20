module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
  
  reg state, next_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 1'b0; // state A
    end else begin
      state <= next_state;
    end
  end
  
  always @* begin
    if (state) begin // state B
      next_state = (k) ? 1'b0 : 1'b1; // next state A if k is high, else stay in B
      out = 1'b1; // set output high when state is B
    end else begin // state A
      next_state = (j) ? 1'b1 : 1'b0; // next state B if j is high, else stay in A
      out = 1'b0; // set output low when state is A
    end
  end
  
endmodule
