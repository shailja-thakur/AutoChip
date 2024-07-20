module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] q_next;
  
  always @(q) begin
    q_next = q[4:1]; // value of q excluding LSB bit
    q_next[4] = q[0]; // LSB bit
    q_next[2] = q_next[2] ^ q[0]; // xor operation
    
    q <= q_next;
  end
  
  always @(posedge clk) begin
    if(reset) begin
      q <= 5'h1; // reset value
    end
    else begin
      q <= q_next;
    end
  end

endmodule
