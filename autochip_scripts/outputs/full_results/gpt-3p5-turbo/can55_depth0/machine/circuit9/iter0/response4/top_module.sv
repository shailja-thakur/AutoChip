module top_module (
  input clk,
  input a, 
  output reg [2:0] q
);

  always @ (posedge clk) begin
    if (a == 1) q <= 3'b100; // When a is 1, q is set to 4.
    else if (a == 0 && q == 3'b110) q <= 3'b000; // When a is 0 and q is 6, q is set to 0.
    else if (a == 0) q <= q + 1; // When a is 0 and q is not 6, q is increased by 1.
  end

endmodule
