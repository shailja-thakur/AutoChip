module top_module (
    input [31:0] in,
    output [31:0] out
);
  
  always @(*) begin
    out[31:24] = in[7:0];
    out[23:16] = in[15:8];
    out[15:8] = in[23:16];
    out[7:0] = in[31:24];
  end
  
endmodule
