module top_module (
  input clk,
  input reset,
  output reg [31:0] q
);

  reg [31:0] q_next;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1;
      q_next <= 32'h1;
    end else begin
      q <= q_next;
      q_next <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
    end
  end
  
  initial begin
    // Add a initial block to simulate the inputs
    reset = 1'b0;
    clk = 1'b0;
    #10;
    
    reset = 1'b1;
    #10;
    
    reset = 1'b0;
    #10;
    
    repeat(20) begin
      clk = ~clk;
      #10;
    end
    
    $finish;
  end

endmodule
