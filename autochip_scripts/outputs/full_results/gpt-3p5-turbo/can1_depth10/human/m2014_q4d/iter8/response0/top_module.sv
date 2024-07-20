module top_module (
    input wire clk,
    input wire in,
    output wire out
);

  reg xor_output;
  reg flip_flop_output;

  always @(posedge clk)
  begin
      xor_output <= in ^ flip_flop_output;
      flip_flop_output <= xor_output;
  end

  assign out = flip_flop_output;

  initial begin
      $dumpfile("wave.vcd");
      $dumpvars(0, top_module);
      $display("Simulation started");
      $monitor("Time = %0d, in = %b, out = %b", $time, in, out);
      #100;
      $display("Simulation finished");
      $finish;
  end

endmodule
