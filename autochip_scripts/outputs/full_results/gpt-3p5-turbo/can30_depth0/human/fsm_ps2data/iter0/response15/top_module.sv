module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

reg [1:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 2'b00;
    byte1 <= 0;
    byte2 <= 0;
    byte3 <= 0;
    done <= 0;
  end else begin
    case(state)
      2'b00:
        if (in[3]) begin
          byte1 <= in;
          state <= 2'b01;
        end
      2'b01:
        byte2 <= in;
        state <= 2'b10;
      2'b10:
        byte3 <= in;
        state <= 2'b00;
        done <= 1;
    endcase
  end
end

always @(posedge clk or posedge reset) begin
  if (reset) begin
    out_bytes <= 0;
  end else begin
    if (done) begin
      out_bytes <= {byte3, byte2, byte1};
    end
  end
end

endmodule
