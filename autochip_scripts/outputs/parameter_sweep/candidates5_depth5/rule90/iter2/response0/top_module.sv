module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  // Internal wire to hold the next state of the system
  wire [511:0] next_state;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      next_state[0] <= q[1] ^ q[511];
      for (int i = 1; i < 511; i = i + 1) begin
        next_state[i] <= q[i-1] ^ q[i+1];
      end
      next_state[511] <= q[510] ^ q[0];
      q <= next_state;
    end
  end
endmodule
