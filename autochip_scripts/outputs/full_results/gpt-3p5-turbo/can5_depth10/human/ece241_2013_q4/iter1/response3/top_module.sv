module top_module (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

reg [3:1] prev_s;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    prev_s <= 3'b000;
    fr3 <= 1'b1;
    fr2 <= 1'b1;
    fr1 <= 1'b1;
    dfr <= 1'b0;
  end else begin
    prev_s <= s;

    case (s)
      3'b111: begin // Above s[3]
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b0;
        dfr <= 1'b0;
      end
      3'b110: begin // Between s[3] and s[2]
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b1;
        dfr <= 1'b0;
      end
      3'b10x: begin // Between s[2] and s[1]
        fr3 <= 1'b0;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
      end
      3'b0xx: begin // Below s[1]
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
      end
      default: begin
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
      end
    endcase
  end
end

endmodule
