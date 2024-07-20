module top_module(
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);

  reg [15:0] q_internal;

  always @(posedge clk or negedge resetn) begin
    if (resetn == 0) begin
      q_internal <= 16'b0;
    end else begin
      if (byteena[0] == 1)
        q_internal[7:0] <= d[7:0];
        
      if (byteena[1] == 1)
        q_internal[15:8] <= d[15:8];
    end
  end

  always @* begin
    q = q_internal;
  end

endmodule
