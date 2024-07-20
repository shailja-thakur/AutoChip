module top_module (
  input clk,
  input in,
  output logic out
);
  
  logic toggle;

  always_ff @(posedge clk) begin
    toggle <= in ^ out;
    out <= toggle;
  end

endmodule
