module top_module (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

reg [3:1] s_delay;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    fr3 <= 1'b1;
    fr2 <= 1'b1;
    fr1 <= 1'b1;
    dfr <= 1'b1;
    s_delay <= 3'b000;
  end else begin
    s_delay <= s;
    case (s_delay)
      3'b000: begin  // No sensors asserted
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
      end
      3'b001: begin  // Below s[1]
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b0;
        dfr <= 1'b0;
      end
      3'b010: begin  // Between s[2] and s[1]
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        if (s_delay[2] && s_delay[1])
          dfr <= 1'b1;
        else
          dfr <= 1'b0;
      end
      3'b011: begin  // Between s[3] and s[2]
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b0;
        if (s_delay[3] && s_delay[2])
          dfr <= 1'b1;
        else
          dfr <= 1'b0;
      end
      3'b100: begin  // Above s[3]
        fr3 <= 1'b1;
        fr2 <= 1'b0;
        fr1 <= 1'b0;
        dfr <= 1'b0;
      end
      default: begin
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
      end
    endcase
  end
end

endmodule
