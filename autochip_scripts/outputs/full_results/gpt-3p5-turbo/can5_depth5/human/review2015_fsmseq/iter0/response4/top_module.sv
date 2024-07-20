module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;

  always @(posedge clk) begin
    if (reset)
      state <= 0;
    else if (state == 0 && data)
      state <= 1;
    else if (state == 1 && data)
      state <= 2;
    else if (state == 2 && data)
      state <= 3;
    else if (state == 3 && !data)
      state <= 4;
    else if (state == 4)
      state <= 0;
  end

  assign start_shifting = (state == 4);

endmodule
