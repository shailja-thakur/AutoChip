module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);

  // Define variables for storing the updated values of each cell
  reg [511:0] next_q;
  
  // Always block triggered by positive edge of the clock
  always @(posedge clk) begin
    if (load) begin
      // If load is high, load the data values into the q register
      q <= data;
    end else begin
      // Update the state of each cell based on Rule 110
      next_q[0] = (q[1] & q[0]) ~| (~q[1] & ~q[0]);
      next_q[511] = (~q[510] & ~q[511]) ~| (q[510] & q[511]);
      
      // Loop through all the cells except for the boundaries
      for (int i = 1; i < 511; i = i + 1) begin
        next_q[i] = (q[i+1] & q[i] & ~q[i-1]) ~| (~q[i+1] & q[i] & q[i-1]) ~| (q[i+1] & ~q[i] & q[i-1]) ~| (~q[i+1] & ~q[i] & ~q[i-1]);
      end
      
      // Update the value of q with the new values
      q <= next_q;
    end
  end

endmodule
