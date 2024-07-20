module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

reg searching;
reg [2:0] state;

always@(posedge clk) begin
  if (reset) begin
    byte1 <= 8'd0;
    byte2 <= 8'd0;
    byte3 <= 8'd0;
    searching <= 1'b0;
    state <= 3'b0;
    done <= 1'b0;
    out_bytes <= 24'd0;
  end else begin
    case (state)
      3'b0:
        if (in[3]) begin
          byte1 <= in;
          byte2 <= 8'd0;
          byte3 <= 8'd0;
          searching <= 1'b1;
          state <= 3'b1;
          done <= 1'b0;
          out_bytes <= 24'd0;
        end else begin
          byte1 <= 8'd0;
          byte2 <= 8'd0;
          byte3 <= 8'd0;
          searching <= 1'b0;
          state <= 3'b0;
          done <= 1'b0;
          out_bytes <= 24'd0;
        end
      3'b1:
        byte2 <= in;
        state <= 3'b2;        
      3'b10:
        byte3 <= in;
        state <= 3'b11;
      3'b11:
        done <= 1'b1;
        searching <= 1'b0;
        state <= 3'b0;
        out_bytes[23:16] <= byte1;
        out_bytes[15:8] <= byte2;
        out_bytes[7:0] <= byte3;
    endcase
  end
end

endmodule
