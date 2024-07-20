module top_module(
  input clk,
  input [7:0] in,
  output reg [7:0] pedge
);

  reg [7:0] prev_in;

  always @(posedge clk) begin
    prev_in <= in;
    pedge <= 0;
    for (integer i=0; i<8; i=i+1) begin
      if (in[i] && !prev_in[i])
        pedge[i] <= 1;
    end
  end

endmodule
