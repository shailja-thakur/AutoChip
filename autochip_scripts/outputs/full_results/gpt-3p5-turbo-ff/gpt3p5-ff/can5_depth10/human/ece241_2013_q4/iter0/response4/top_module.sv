module top_module (
  input clk,
  input reset,
  input [2:0] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

  reg [2:0] prev_s;

  always @(posedge clk or posedge reset) begin
    if (reset)
      prev_s <= 3'b000;
    else
      prev_s <= s;
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      dfr <= 1'b1;
      fr1 <= 1'b1;
      fr2 <= 1'b1;
      fr3 <= 1'b1;
    end
    else case ({prev_s, s})
      3'b111: begin
        dfr <= 1'b0;
        fr1 <= 1'b0;
        fr2 <= 1'b0;
        fr3 <= 1'b0;
      end
      3'b110: begin
        dfr <= 1'b0;
        fr1 <= 1'b1;
        fr2 <= 1'b1;
        fr3 <= 1'b1;
      end
      3'b100: begin
        dfr <= 1'b0;
        fr1 <= 1'b1;
        fr2 <= 1'b1;
        fr3 <= 1'b0;
      end
      3'b000: begin
        dfr <= 1'b0;
        fr1 <= 1'b1;
        fr2 <= 1'b0;
        fr3 <= 1'b0;
      end
    endcase
  end

endmodule
