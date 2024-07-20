module top_module (
  input logic clk,
  input logic in,
  output logic out
);

  logic prev_out;

  always_ff @(posedge clk) begin
    prev_out <= out;
    out <= in ^ prev_out;
  end

endmodule
