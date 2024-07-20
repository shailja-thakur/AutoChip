module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

  always @(posedge clock) begin
    if (a) begin
      p <= ~p;
      q <= ~q;
    end
  end

initial begin
  $dumpfile("wave.vcd");
  $dumpvars(0, top_module);
  
  p <= 0;
  q <= 0;
  
  #25 a <= 1;
  #10 a <= 0;
  #5 a <= 1;
  #5 a <= 0;
  #5 a <= 1;
  #5 a <= 0;
  #5 a <= 1;
  #10 $finish;
end

endmodule
