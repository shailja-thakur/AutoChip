module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);
  
  reg next_state, d;
  
  always @(posedge clk) begin
    state <= next_state;
    q <= d;
  end
  
  always @(state, a, b) begin
    case (state)
      0: begin
        if (a & ~b)
          next_state = 1;
        else
          next_state = 0;
        d = 0;
      end
      
      1: begin
        if (a | b)
          next_state = 0;
        else
          next_state = 1;
        d = 1;
      end
    endcase
  end
endmodule
