module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  always @(posedge clk) begin
    if (reset) begin
      q <= 32'h1;
    end else begin
      q <= {q[30:0], q[22] ^ q[21] ^ q[1] ^ q[0]};
    end
  end

  initial begin
    // Initialize inputs
    clk = 0;
    reset = 1;
    
    // Wait for reset to be released
    #10 reset = 0;
    
    // Toggle clock and simulate
    repeat(100) begin
      #5 clk = ~clk;
    end
    
    // End simulation
    $finish;
  end

endmodule
