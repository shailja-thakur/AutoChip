module top_module(
  input wire clk,
  input wire L,
  input wire q_in,
  input wire r_in,
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

    // Test cases
    #10;
    clk = 0;
    L = 0;
    q_in = 0;
    r_in = 0;
    
    #10;
    clk = 1;
    L = 0;
    q_in = 1;
    r_in = 0;
    
    #10;
    clk = 0;
    L = 1;
    q_in = 0;
    r_in = 1;
    
    #10;
    clk = 1;
    L = 1;
    q_in = 1;
    r_in = 0;
    
    #10;
    clk = 0;
    L = 1;
    q_in = 0;
    r_in = 1;
    
    #10;
    clk = 1;
    L = 0;
    q_in = 0;
    r_in = 0;
    
    #10;
    clk = 0;
    L = 0;
    q_in = 0;
    r_in = 1;
    
    #10;
    clk = 1;
    L = 1;
    q_in = 1;
    r_in = 1;

    $finish;
  end
endmodule
