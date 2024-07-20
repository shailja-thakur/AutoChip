module top_module (
  input a,
  input b,
  input cin,
  output reg cout,
  output reg sum
);

  always @(a, b, cin) begin
    sum = (a + b + cin) % 2;
    cout = (a + b + cin) >= 2 ? 1'b1 : 1'b0;
  end

endmodule
