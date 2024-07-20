module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output reg [3:0] out
);

always @(*) begin
  out = in[sel];
end

endmodule
