module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
  );

  reg [511:0] temp;

  // Boundary conditions
  assign q[-1] = 1'b0;
  assign q[512] = 1'b0;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      temp[511] <= (q[510] & q[511]) | (q[510] & ~q[509]);
      temp[510:0] <= q[511:1];
      q <= temp;
    end
  end

endmodule
