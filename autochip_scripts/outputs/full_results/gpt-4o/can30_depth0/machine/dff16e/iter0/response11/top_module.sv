module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      q <= 16'b0; // Reset the register to 0 when resetn is low
    else begin
      if (byteena[0])
        q[7:0] <= d[7:0]; // Write lower 8 bits of data to lower 8 bits of q
      if (byteena[1])
        q[15:8] <= d[15:8]; // Write upper 8 bits of data to upper 8 bits of q
    end
  end
  
endmodule
