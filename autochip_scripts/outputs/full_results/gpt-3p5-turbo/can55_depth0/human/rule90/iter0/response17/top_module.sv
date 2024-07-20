module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

  reg [511:0] q_temp;

  always @(posedge clk) begin
    if (load)
      q_temp <= data;
    else begin
      q_temp[0] = q[1] ^ q[511];
      q_temp[1] = q[0] ^ q[2];
      q_temp[2:509] = q[1:508] ^ q[3:510];
      q_temp[510] = q[509] ^ q[511];
      q_temp[511] = q[510] ^ q[0];
    end
  end

  always @(posedge clk) begin
    q <= q_temp;
  end

endmodule
