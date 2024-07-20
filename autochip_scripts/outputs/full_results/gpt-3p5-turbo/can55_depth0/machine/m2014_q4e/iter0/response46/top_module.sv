module top_module (
  input logic in1,
  input logic in2,
  output logic out
);

  // Combinational logic
  always_comb begin
    out = ~(in1 | in2);
  end

endmodule
