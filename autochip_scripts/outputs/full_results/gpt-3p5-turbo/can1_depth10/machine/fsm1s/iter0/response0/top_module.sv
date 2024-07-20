module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  
  always @(posedge clk) begin
    if (reset)
      state <= 2'b1;
    else if (state == 2'b01 && in)
      state <= 2'b10;
    else if (state == 2'b10 && !in)
      state <= 2'b01;
  end
  
  assign out = (state == 2'b10);
  
endmodule
