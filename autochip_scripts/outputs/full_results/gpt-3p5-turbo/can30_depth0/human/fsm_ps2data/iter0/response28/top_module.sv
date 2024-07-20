module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [23:0] out_bytes_reg;
  reg [23:0] out_bytes_next;
  reg done_reg;
  reg done_next;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      out_bytes_reg <= 24'd0;
    else
      out_bytes_reg <= out_bytes_next;
  end
  
  always @(posedge clk or posedge reset) begin 
    if (reset)
      done_reg <= 1'b0;
    else
      done_reg <= done_next;
  end
  
  always @(posedge clk) begin
    out_bytes_next = {out_bytes_reg[15:0], out_bytes_reg[23:16], in};
    done_next = (out_bytes_reg[23] == 1'b1);
  end
  
  assign out_bytes = out_bytes_reg;
  assign done = done_reg;
  
endmodule
