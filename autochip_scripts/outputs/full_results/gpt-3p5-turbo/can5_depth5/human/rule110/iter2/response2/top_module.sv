module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  reg [511:0] temp;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      temp[0] <= (q[0] & ~q[1]) | (~q[0] & (q[1] | data[0]));
      for (integer i = 1; i < 511; i = i + 1) begin
        temp[i] <= (q[i] & ~(q[i-1] & q[i+1])) | (~q[i] & ((q[i-1] | q[i+1]) & ~(data[i-1] & data[i+1])));
      end
      temp[511] <= (~q[511] & (data[510] | q[510]));
      q <= temp;
    end
  end

endmodule
