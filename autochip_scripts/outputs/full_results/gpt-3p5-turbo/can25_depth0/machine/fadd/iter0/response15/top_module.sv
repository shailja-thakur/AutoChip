module top_module (
  input a,
  input b,
  input cin,
  output reg cout,
  output reg sum
);

  always @(*) begin
    {cout, sum} = a + b + cin;
    if(a + b + cin >= 2) begin
      cout = 1;
    end else begin
      cout = 0;
    end
    sum = (a + b + cin) % 2;
  end

endmodule
