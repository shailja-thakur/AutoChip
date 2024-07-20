module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);
 
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [7:0] tmp1;
reg [7:0] tmp2;
wire match;
reg done_reg;
 
always @(posedge clk) begin
  if (reset) begin
    byte1 <= 8'b0;
    byte2 <= 8'b0;
    byte3 <= 8'b0;
    done_reg <= 1'b0;
  end else begin
    if (byte3 == 8'b0) begin
      if (in[3] == 1'b1) begin
        byte1 <= in;
        byte2 <= 8'b0;
        byte3 <= 8'b0;
      end
    end else if (byte3 == 8'b0) begin
      if (in[3] == 1'b1) begin
        byte2 <= in;
        byte3 <= 8'b0;
      else begin
        byte1 <= byte1;
        byte2 <= in;
        byte3 <= byte3;
      end
    end else begin
      if (in[3] == 1'b1) begin
        byte3 <= in;
      end
      if (byte1[3] == 1'b1 && byte2[3] == 1'b1 && byte3[3] == 1'b1) begin
        done_reg <= 1'b1;
      end else begin
        done_reg <= 1'b0;
      end
    end
  end
end
 
assign match = (byte1[3] == 1'b1 && byte2[3] == 1'b1 && byte3[3] == 1'b1);
 
always @(posedge clk) begin
  if (done_reg) begin
    out_bytes <= {byte1, byte2, byte3};
  end else begin
    out_bytes <= 24'b0;
  end
end
 
assign done = done_reg;
 
endmodule
