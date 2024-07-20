module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
  reg [7:0] byte1, byte2, byte3;
  reg done_reg;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      byte1 <= 8'b0;
      byte2 <= 8'b0;
      byte3 <= 8'b0;
      done_reg <= 1'b0;
    end else begin
      if (done_reg) begin
        byte1 <= in;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
        done_reg <= 1'b0;
      end else if (byte3[3] == 1'b1) begin
        byte3 <= in;
        done_reg <= 1'b1;
      end else if (byte2[3] == 0 && byte1[3] == 0) begin
        byte1 <= in;
      end else if (byte2[3] == 1'b1 && byte3[3] == 0) begin
        byte2 <= in;
      end else begin
        byte1 <= in;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
      end
    end
  end
  
  assign out_bytes = {byte1, byte2, byte3};
  assign done = done_reg;
endmodule
