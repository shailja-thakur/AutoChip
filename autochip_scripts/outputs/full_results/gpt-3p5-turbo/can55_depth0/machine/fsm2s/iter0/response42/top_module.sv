module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
  
  reg state, next_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 0;
    else
      state <= next_state;
  end
  
  always @(state or j or k) begin
    case (state)
      0: begin
        if (j)
          next_state = 1;
        else
          next_state = 0;
        out = 0;
      end
      1: begin
        if (k)
          next_state = 0;
        else
          next_state = 1;
        out = 1;
      end
    endcase
  end
  
endmodule
