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
    assign clk = 0;
    assign L = 0;
    assign q_in = 0;
    assign r_in = 0;
    
    #10;
    assign clk = 1;
    assign L = 0;
    assign q_in = 1;
    assign r_in = 0;
    
    #10;
    assign clk = 0;
    assign L = 1;
    assign q_in = 0;
    assign r_in = 1;
    
    #10;
    assign clk = 1;
    assign L = 1;
    assign q_in = 1;
    assign r_in = 0;
    
    #10;
    assign clk = 0;
    assign L = 1;
    assign q_in = 0;
    assign r_in = 1;
    
    #10;
    assign clk = 1;
    assign L = 0;
    assign q_in = 0;
    assign r_in = 0;
    
    #10;
    assign clk = 0;
    assign L = 0;
    assign q_in = 0;
    assign r_in = 1;
    
    #10;
    assign clk = 1;
    assign L = 1;
    assign q_in = 1;
    assign r_in = 1;

    $finish;
  end
endmodule
