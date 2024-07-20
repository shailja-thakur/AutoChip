module top_module (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);

always @(sel, a, b)
begin
  if (sel == 0)
    out <= b;
  else if (sel == 1)
    out <= a;
  else
    out <= 8'd0; // Default value if sel is not 0 or 1
end

endmodule
