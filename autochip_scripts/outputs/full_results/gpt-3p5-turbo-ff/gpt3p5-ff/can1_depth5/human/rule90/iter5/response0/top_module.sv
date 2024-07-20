module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      
      // Create a temporary variable to store the updated state of q
      reg [511:0] q_next;
      
      q_next[511] <= 0; // Boundary condition for q[511]
      q_next[0] <= 0; // Boundary condition for q[0]
      
      // Calculation for cells 1 to 510
      for (integer i = 1; i < 511; i = i+1) begin
        q_next[i] <= q[i-1] ^ q[i+1];
      end

      q_next[511] <= q[510] ^ 0;
      q_next[0] <= q[511] ^ q[1];

      // Assign q_next back to q
      q <= q_next;
    end
  end

endmodule
