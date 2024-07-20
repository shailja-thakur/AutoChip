module top_module (
  input in1,
  input in2,
  output reg out
);

// Combinational logic for negation of logical OR
always @(*) begin
  out = ~(in1 | in2);
end

endmodule
