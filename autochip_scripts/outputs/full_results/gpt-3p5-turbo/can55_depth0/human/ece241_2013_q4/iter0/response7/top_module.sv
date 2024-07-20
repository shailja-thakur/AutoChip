module top_module (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

reg [2:0] state;
reg [1:0] prev_sensor;

parameter IDLE = 3'b000;
parameter ABOVE_S3 = 3'b001;
parameter BETWEEN_S3_AND_S2 = 3'b010;
parameter BETWEEN_S2_AND_S1 = 3'b011;
parameter BELOW_S1 = 3'b100;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= IDLE;
    fr3 <= 1'b1;
    fr2 <= 1'b1;
    fr1 <= 1'b1;
    dfr <= 1'b0;
  end else begin
    prev_sensor <= s;
    case (state)
      IDLE:
        if (s == 3'b111) begin
          state <= ABOVE_S3;
          fr3 <= 1'b0;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b0;
        end else if (s == 3'b110) begin
          state <= BETWEEN_S3_AND_S2;
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b0;
          dfr <= 1'b0;
        end else if (s == 3'b100) begin
          state <= BELOW_S1;
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b1;
        end
      ABOVE_S3:
        if (s == 3'b011) begin
          state <= BETWEEN_S3_AND_S2;
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b0;
          dfr <= 1'b0;
        end else if (s == 3'b010) begin
          state <= BETWEEN_S2_AND_S1;
          fr3 <= 1'b1;
          fr2 <= 1'b0;
          fr1 <= 1'b0;
          dfr <= 1'b0;
        end else if (s == 3'b001) begin
          state <= BELOW_S1;
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b1;
        end
      BETWEEN_S3_AND_S2:
        if (s == 3'b010) begin
          state <= BETWEEN_S2_AND_S1;
          fr3 <= 1'b1;
          fr2 <= 1'b0;
          fr1 <= 1'b0;
          dfr <= 1'b0;
        end else if (s == 3'b001) begin
          state <= BELOW_S1;
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b1;
        end
      BETWEEN_S2_AND_S1:
        if (s == 3'b001) begin
          state <= BELOW_S1;
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b1;
        end
      BELOW_S1:
        // No state transitions from BELOW_S1
    endcase
  end
end

endmodule
