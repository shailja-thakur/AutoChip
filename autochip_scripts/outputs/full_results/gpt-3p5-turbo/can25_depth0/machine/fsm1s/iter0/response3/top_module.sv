module top_module (
  input wire clk,
  input wire in,
  input wire reset,
  output wire out
);

  reg [1:0] state;
  parameter A = 0;
  parameter B = 1;

  always @(posedge clk) begin
    if (reset)
      state <= B;
    else if (state == A && in)
      state <= A;
    else if (state == A && !in)
      state <= B;
    else if (state == B && in)
      state <= B;
    else if (state == B && !in)
      state <= A;
  end

  assign out = (state == B) ? 1'b1 : 1'b0;
endmodule
