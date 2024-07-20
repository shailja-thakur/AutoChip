module toggle_ff (
  input clk,
  input in,
  output logic out
);

  logic prev_out;

  always_ff @(posedge clk) begin
    out <= in ^ prev_out;
    prev_out <= out;
  end

endmodule
module top_module (
  input clk,
  input in,
  output logic out
);

  toggle_ff toggle_ff_inst (
    .clk(clk),
    .in(in),
    .out(out)
  );

endmodule
