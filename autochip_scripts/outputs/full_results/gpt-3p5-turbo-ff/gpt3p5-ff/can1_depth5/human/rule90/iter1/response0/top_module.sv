module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q[511] <= q[510] ^ 0;
      q[0] <= q[511] ^ q[1];
      
      // Calculation for cells 1 to 510
      for (integer i = 1; i < 511; i = i+1) begin
        q[i] <= q[i-1] ^ q[i+1];
      end
      
      q[511] <= 0; // Boundary condition for q[511]
      q[0] <= 0; // Boundary condition for q[0]
    end
  end

endmodule
