module top_module (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

reg [3:1] s_reg;
reg [3:1] prev_s_reg;
reg [2:0] state;

parameter ABOVE_S3 = 0;
parameter BETWEEN_S3_S2 = 1;
parameter BETWEEN_S2_S1 = 2;
parameter BELOW_S1 = 3;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= ABOVE_S3;
    s_reg <= 3'b0;
    prev_s_reg <= 3'b0;
    fr3 <= 1'b1;
    fr2 <= 1'b1;
    fr1 <= 1'b1;
    dfr <= 1'b1;
  end else begin
    case (state)
      ABOVE_S3: begin
        if (s[3]) begin
          state <= BETWEEN_S3_S2;
        end
      end
      BETWEEN_S3_S2: begin
        if (!s[3] && s[2]) begin
          state <= BETWEEN_S2_S1;
        end else if (s[1]) begin
          state <= BELOW_S1;
        end
      end
      BETWEEN_S2_S1: begin
        if (!s[2] && s[1]) begin
          state <= BELOW_S1;
        end
      end
      BELOW_S1: begin
        if (!s[1]) begin
          state <= ABOVE_S3;
        end
      end
    endcase
  end
end

always @(posedge clk) begin
  case (state)
    ABOVE_S3: begin
      fr3 <= 1'b0;
      fr2 <= 1'b0;
      fr1 <= 1'b0;
      dfr <= 1'b0;
    end
    BETWEEN_S3_S2: begin
      fr3 <= 1'b0;
      fr2 <= 1'b0;
      fr1 <= 1'b1;
      dfr <= 1'b0;
    end
    BETWEEN_S2_S1: begin
      fr3 <= 1'b0;
      fr2 <= 1'b1;
      fr1 <= 1'b1;
      if (s_reg[2] < prev_s_reg[2]) begin
        dfr <= 1'b1;
      end else begin
        dfr <= 1'b0;
      end
    end
    BELOW_S1: begin
      fr3 <= 1'b1;
      fr2 <= 1'b1;
      fr1 <= 1'b1;
      if (s_reg[3] < prev_s_reg[3]) begin
        dfr <= 1'b1;
      end else begin
        dfr <= 1'b0;
      end
    end
  endcase
end

always @(posedge clk) begin
  s_reg <= s;
  prev_s_reg <= s_reg;
end

endmodule
