module top_module(
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);

  reg [7:0] dff [0:7];

  always @(negedge clk) begin
    if(reset) begin
      for(int i=0; i<8; i=i+1)
        dff[i] <= 8'd34;
    end else begin
      for(int i=0; i<8; i=i+1)
        dff[i] <= d[i];
    end
  end

  always @(posedge clk) begin
    for(int i=0; i<8; i=i+1)
      q[i] <= dff[i];
  end

endmodule
