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
      temp = q;
      q[0] = temp[1];                   // Rule 110 logic
      q[1] = temp[2] ^ (temp[0] & temp[2]);
      q[2:509] = temp[3:510] ^ (temp[1:508] & temp[3:510]);
      q[510] = temp[509] ^ (temp[510] & temp[508]);
      q[511] = temp[510];
    end
  end

endmodule
