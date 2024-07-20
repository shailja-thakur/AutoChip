module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] anyedge);

  reg [7:0] prev_in;

  always @(posedge clk) begin
    prev_in <= in;
    anyedge <= 0;
    for (int i = 0; i < 8; i=i+1) begin
      if (prev_in[i] == 1'b0 && in[i] == 1'b1)
        anyedge[i] <= 1'b1;
    end
  end

endmodule
