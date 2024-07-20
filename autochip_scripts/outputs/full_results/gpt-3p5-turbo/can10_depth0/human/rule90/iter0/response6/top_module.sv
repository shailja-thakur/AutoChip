module top_module (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
  reg [511:0] q_temp; // Temporary register for storing the updated state
  
  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q_temp[0] = q[1] ^ q[0]; // Calculate the next state for the first cell (boundary case)
      for (int i = 1; i < 511; i = i + 1) begin
        q_temp[i] = q[i-1] ^ q[i+1]; // Calculate the next state for the intermediate cells
      end
      q_temp[511] = q[510] ^ q[511]; // Calculate the next state for the last cell (boundary case)
      q <= q_temp; // Update the state
    end
  end
endmodule
