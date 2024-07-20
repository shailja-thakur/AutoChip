module top_module (
  input clk,
  input in,
  output logic out
);

  always_ff @(posedge clk) begin
    if (clk) begin
      out <= ~out;
    end
  end

endmodule
