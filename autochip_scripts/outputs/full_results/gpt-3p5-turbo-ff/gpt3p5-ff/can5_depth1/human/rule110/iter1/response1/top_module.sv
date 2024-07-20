module top_module(
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q);

  reg [511:0] temp;
  wire [513:0] q_extended;

  always @* begin
    q_extended[0] = 1'b0;
    q_extended[1:512] = q;
    q_extended[513] = 1'b0;
    if (load) begin
      q <= data;
    end else begin
      for (int i = 0; i < 512; i = i + 1) begin
        temp[i] = (q_extended[i+1] & q_extended[i+2]) | (q_extended[i+2] & q_extended[i+3]) |
                  (q_extended[i+1] & ~q_extended[i+4]) | (~q_extended[i+2] & ~q_extended[i+4]);
      end
      q <= temp;
    end
  end

endmodule
