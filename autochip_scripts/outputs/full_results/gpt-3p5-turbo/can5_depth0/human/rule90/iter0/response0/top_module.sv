module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
  
  always @(posedge clk) begin
    if (load) begin
      q <= data; // Load initial state
    end else begin
      q[511] <= q[510] ^ q[0]; // Compute the next state of the first cell
      for (int i = 1; i < 511; i = i + 1) begin
        q[i] <= q[i-1] ^ q[i+1]; // Compute the next state of each cell
      end
      q[0] <= q[1] ^ q[511]; // Compute the next state of the last cell
    end
  end

endmodule
