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
reg [1:0] state;

always @(posedge clk) begin
  if (reset) begin
    byte1 <= 8'b0;
    byte2 <= 8'b0;
    byte3 <= 8'b0;
    state <= 2'b00;
    done <= 0;
    out_bytes <= 24'b0;
  end else begin
    case(state)
      2'b00:
        if (in[3] && ~done) begin
          state <= 2'b01;
          byte1 <= in;
        end
      2'b01:
        if (~in[3] && ~done) begin
          byte2 <= in;
          state <= 2'b10;
        end
      2'b10:
        if (~in[3] && ~done) begin
          byte3 <= in;
          state <= 2'b00;
          done <= 1;
          out_bytes <= {byte1, byte2, byte3};
        end
    endcase
  end
end

endmodule
