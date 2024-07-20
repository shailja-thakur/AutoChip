module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge
);

  reg [7:0] in_prev;
  reg [7:0] edge_detected;

  always @(posedge clk) begin
    in_prev <= in;
  end

  always @(posedge clk) begin
    edge_detected <= in & (~in_prev);
  end

  always @(posedge clk) begin
    anyedge <= edge_detected;
  end

endmodule
