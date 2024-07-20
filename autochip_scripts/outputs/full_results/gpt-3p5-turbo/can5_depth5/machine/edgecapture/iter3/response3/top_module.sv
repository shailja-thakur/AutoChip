module top_module(
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out);
  
  reg [31:0] d_last;
  reg clk_prev;
  
  always @(posedge clk) begin
    clk_prev <= clk;
    if (reset)
      out <= 0;
    else begin
      out <= out | (~in & d_last);
      d_last <= in;
    end
  end
  
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);
    $monitor($time, " Reset = %b, In = %b, Out = %b", reset, in, out);
    
    clk = 0;
    reset = 1;
    
    #10 reset = 0;
    
    #10 in = 32'h12345678;
    #10 in = 32'h87654321;
    
    #100 $finish;
  end
  
endmodule
