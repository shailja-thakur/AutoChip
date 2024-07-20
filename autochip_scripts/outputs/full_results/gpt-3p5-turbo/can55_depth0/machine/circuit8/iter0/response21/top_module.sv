module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

// Register assignment on the negative edge of the clock signal
always @(negedge clock)
begin
  q <= a;
end

// Register assignment on any change of input signal a
always @(a)
begin
  if (clock)
    p <= a;
end

endmodule
