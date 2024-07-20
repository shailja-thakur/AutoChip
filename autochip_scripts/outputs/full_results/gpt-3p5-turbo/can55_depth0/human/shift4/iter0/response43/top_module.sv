module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      q <= 4'b0000; // (1) reset shift register to zero
    end else begin
      if (load) begin
        q <= data; // (2) load shift register with data instead of shifting
      end else if (ena) begin
        q <= {q[2:0], 1'b0}; // (3) shift right
      end
    end
  end

endmodule
