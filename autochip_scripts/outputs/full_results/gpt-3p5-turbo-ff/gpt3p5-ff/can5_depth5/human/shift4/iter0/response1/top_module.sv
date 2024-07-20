module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);

reg [3:0] temp;

always @(posedge clk or posedge areset) begin
  if (areset)
    temp <= 0;
  else if(load)
    temp <= data;
  else if(ena)
    temp <= {temp[2:0], 1'b0};
end

assign q = temp;

endmodule
