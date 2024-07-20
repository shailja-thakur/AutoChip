module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] q_next;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 5'b1;
    end else begin
      q <= q_next;
    end
  end

  always @* begin
    q_next[4:1] = q[3:0];
    q_next[0] = q[4];
    q_next[2] = q[2] ^ q[0];
  end

endmodule
module top_module_tb();
  
  reg clk;
  reg reset;
  wire [4:0] q;
  
  top_module UUT(
    .clk(clk),
    .reset(reset),
    .q(q)
  );
  
  initial begin
    clk = 0;
    reset = 0;
    #100;
    
    reset = 1;
    #100;
    
    reset = 0;
    #1000;
    
    $finish;
  end

  always begin
    #10;
    clk = ~clk;
  end

endmodule
