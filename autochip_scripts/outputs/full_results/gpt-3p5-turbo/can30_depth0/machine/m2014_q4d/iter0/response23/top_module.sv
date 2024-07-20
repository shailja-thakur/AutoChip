module top_module (
  input logic clk,
  input logic in,
  output logic out
);

  logic previous_out;
  
  always_ff @(posedge clk) begin
    previous_out <= out;
    out <= in ^ previous_out;
  end
  
endmodule
