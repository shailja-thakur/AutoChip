module top_module (
  input clk,
  input a,
  output reg [2:0] q
);

always @(posedge clk) begin
  case ({a, q[2], q[1], q[0]})
    {1, 0, 0, 0}: q <= 1;
    {1, 0, 0, 1}: q <= 2;
    {1, 0, 1, 0}: q <= 3;
    {1, 0, 1, 1}: q <= 4;
    {1, 1, 0, 0}: q <= 5;
    {1, 1, 0, 1}: q <= 6;
    {1, 1, 1, 0}: q <= 0;
    {1, 1, 1, 1}: q <= 0;
  endcase
end

endmodule
