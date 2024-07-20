module top_module(
  input wire clk,
  input wire resetn,
  input wire [1:0] byteena,
  input wire [15:0] d,
  output reg [15:0] q
);
  
  always @(posedge clk) begin
    if (resetn == 0) begin
      q <= 0; // Reset the register to 0
    end else begin
      if (byteena[0] == 1) begin
        q[7:0] <= d[7:0]; // Write lower 8 bits of data to lower 8 bits of register
      end
      
      if (byteena[1] == 1) begin
        q[15:8] <= d[15:8]; // Write upper 8 bits of data to upper 8 bits of register
      end
    end
  end
  
endmodule
