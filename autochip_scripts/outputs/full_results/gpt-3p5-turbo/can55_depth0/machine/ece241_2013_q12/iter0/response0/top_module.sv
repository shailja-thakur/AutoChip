module top_module (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg [7:0] q
);

  reg [2:0] addr;
  
  always @(posedge clk) begin
    if (enable) begin
      q <= {S, q[7:1]};
    end
    addr <= {A, B, C};
    Z <= q[addr];
  end

endmodule
