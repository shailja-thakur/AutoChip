module top_module(
  input clk,
  input d,
  output reg q
);

  // Declare internal signal to hold the current value of "q"
  reg q_internal;

  // Assign initial value of "q" to 1'bX
  initial begin
    q_internal <= 1'bX;
  end

  // Always block triggered by the rising edge of "clk"
  always @(posedge clk) begin
    q_internal <= d;
  end

  // Assign output "q" to the value of internal signal "q_internal"
  assign q = q_internal;

endmodule
