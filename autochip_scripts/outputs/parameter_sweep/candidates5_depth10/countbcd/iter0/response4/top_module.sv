module top_module (
  input clk,
  input reset,
  output [3:1] ena,
  output reg [15:0] q
);

reg [3:0] count_ones;
always @(posedge clk or posedge reset) begin
  if (reset)
    count_ones <= 4'b0000;
  else if (ena[1])
    count_ones <= count_ones + 1;
end

reg [3:0] count_tens;
always @(posedge clk or posedge reset) begin
  if (reset)
    count_tens <= 4'b0000;
  else if (ena[2])
    count_tens <= count_tens + 1;
end

reg [3:0] count_hundreds;
always @(posedge clk or posedge reset) begin
  if (reset)
    count_hundreds <= 4'b0000;
  else if (ena[3])
    count_hundreds <= count_hundreds + 1;
end

always @(count_ones or count_tens or count_hundreds) begin
  q[3:0] = count_ones;
  q[7:4] = count_tens;
  q[11:8] = count_hundreds;
end

assign ena = {1, 1, ena[2]};

endmodule
