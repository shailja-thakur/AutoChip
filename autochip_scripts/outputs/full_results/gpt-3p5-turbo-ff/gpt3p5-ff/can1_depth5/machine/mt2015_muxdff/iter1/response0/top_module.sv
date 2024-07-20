module top_module(
  input clk,
  input L,
  input q_in,
  input r_in,
  output reg Q);

  always @(posedge clk) begin
    if (L)
      Q <= r_in;
    else
      Q <= q_in;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, top_module);

    $monitor("Time=%0t Q=%b", $time, Q);

    // Test case 1
    #5 clk = 0;
    #5 L = 0;
    #5 q_in = 0;
    #5 r_in = 0;

    // Test case 2
    #5 clk = 1;
    #5 L = 0;
    #5 q_in = 1;
    #5 r_in = 0;

    // Test case 3
    #5 clk = 0;
    #5 L = 1;
    #5 q_in = 0;
    #5 r_in = 1;

    // Test case 4
    #5 clk = 1;
    #5 L = 1;
    #5 q_in = 1;
    #5 r_in = 0;

    // Test case 5
    #5 clk = 0;
    #5 L = 1;
    #5 q_in = 0;
    #5 r_in = 1;

    // Test case 6
    #5 clk = 1;
    #5 L = 0;
    #5 q_in = 0;
    #5 r_in = 0;

    // Test case 7
    #5 clk = 0;
    #5 L = 0;
    #5 q_in = 0;
    #5 r_in = 1;

    // Test case 8
    #5 clk = 1;
    #5 L = 1;
    #5 q_in = 1;
    #5 r_in = 1;

    $finish;
  end

endmodule
