module top_module(
  input clk,
  input reset,
  output reg [31:0] q);
  
  reg [31:0] q_next; // Declare q_next register
  
  always @(posedge clk) begin // Synchronize register with positive edge of clk
    if (reset) begin // If reset is high
      q <= 32'h1; // Reset q to initial value
    end else begin // If reset is low
      q <= q_next; // Update q with the value stored in q_next
    end
  end
  
  always @(posedge clk) begin // Update q_next on every clock cycle
    q_next[31:1] <= q[30:0]; // Shift the value of q by 1 bit
    q_next[21] <= q[0] ^ q[1]; // XOR bit 21 with the value of bit 0 and bit 1
    q_next[0] <= q[0] ^ q[1]; // XOR bit 0 with the value of bit 0 and bit 1
  end
endmodule
