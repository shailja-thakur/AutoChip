module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);
  reg [1:0] state, next_state;
 
  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
 
  always @(posedge clk or negedge aresetn) begin
    if (~aresetn)
      state <= S0;
    else
      state <= next_state;
  end
 
  always @(state or x) begin
    case (state)
      S0:
        if (x == 1'b1)
          next_state = S1;
        else
          next_state = S0;
      S1:
        if (x == 1'b0)
          next_state = S1;
        else
          next_state = S2;
      S2:
        if (x == 1'b1)
          next_state = S0;
        else
          next_state = S1;
    endcase
  end
 
  always @(state) begin
    if (state == S2)
      z = 1'b1;
    else
      z = 1'b0;
  end
 
endmodule
