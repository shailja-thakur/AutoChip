module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

reg [7:0] count;
reg add_val;
reg sub_val;

always @(posedge clk or posedge areset) begin
  if (areset)
    count <= 0;
  else if (count == 7)
    count <= 0;
  else
    count <= count + 1;
end

always @(posedge clk) begin
  if (areset)
    z <= 0;
  else if (count == 0)
    z <= x;
  else begin
    if (count == 1)
      add_val <= x;
    if (count == 7)
      sub_val <= ~x + 1;
    if (count == 6)
      z <= sub_val;
    else
      z <= z + add_val;
  end
end

endmodule
