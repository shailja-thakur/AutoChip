module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);

  reg [1:0] state;
  reg [1:0] next_state;
  
  always @(posedge clk) begin
    if (reset)
      state <= 2'b01;
    else
      state <= next_state;
  end
  
  always @(*) begin
    if (reset)
      next_state = 2'b01;
    else begin
      if (state == 2'b01 && in)
        next_state = 2'b10;
      else if (state == 2'b10 && !in)
        next_state = 2'b01;
      else
        next_state = state;
    end
  end
  
  always @(posedge clk) begin
    if (reset)
      out <= 1'b1;
    else
      out <= (state == 2'b10);
  end
  
endmodule
