module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q);

always @(posedge clk or negedge resetn) begin
  if (~resetn) begin // Reset the register to 0 when resetn signal is low
    q <= 16'b0;
  end else begin // Write data to the register based on the byte enable signal
    if (byteena[0]) begin // Write lower 8 bits of data
      q[7:0] <= d[7:0];
    end
    if (byteena[1]) begin // Write upper 8 bits of data
      q[15:8] <= d[15:8];
    end
  end
end

endmodule
