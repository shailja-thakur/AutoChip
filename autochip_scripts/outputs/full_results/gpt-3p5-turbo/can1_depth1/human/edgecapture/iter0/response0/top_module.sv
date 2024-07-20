module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);

  reg [31:0] previous_state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      previous_state <= 0;
    else
      previous_state <= in;
  end

  always @(posedge clk) begin
    out <= in & (~previous_state);
  end

endmodule
