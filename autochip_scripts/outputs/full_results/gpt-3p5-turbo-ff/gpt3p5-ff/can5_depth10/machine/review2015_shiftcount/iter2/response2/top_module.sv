module top_module(
input clk,
input shift_ena,
input count_ena,
input data,
output reg [3:0] q);

  always @(posedge clk)
  begin
    if(shift_ena)
      q <= data;
    else if(count_ena)
      q <= q - 1;
    else
      q <= q;
  end

  initial
  begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);
    #100;
    $finish;
  end

endmodule
