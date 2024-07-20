module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);
  
  reg state, next_state;
  
  always @(posedge clk or posedge reset) begin
    if(reset)
      state <= 1'b0;
    else
      state <= next_state;
  end
  
  always @(state, j, k) begin
    case(state)
      1'b0: begin
        if(j)
          next_state <= 1'b1;
        else
          next_state <= state;
      end
      1'b1: begin
        if(k)
          next_state <= 1'b0;
        else
          next_state <= state;
      end
    endcase
  end
  
  assign out = state;
  
endmodule
