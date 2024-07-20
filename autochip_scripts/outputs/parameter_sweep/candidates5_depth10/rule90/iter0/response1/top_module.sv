module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  // Register for storing the next state of each cell
  reg [511:0] next_state;

  // Always block to update the next state of each cell
  always @(posedge clk) begin
    if (load) begin
      // Load the initial state of the system
      q <= data;
    end else begin
      // Calculate the next state of each cell based on the Rule 90 cellular automaton rules
      // Handle boundary cells separately (q[-1] and q[512] are both zero)
      next_state[0] = q[1] ^ q[0];
      next_state[511] = q[511] ^ q[510];

      // Update the next state for the internal cells
      for (int i = 1; i < 511; i = i + 1) begin
        next_state[i] = q[i-1] ^ q[i+1];
      end
      
      // Update the current state with the next state
      q <= next_state;
    end
  end

endmodule
