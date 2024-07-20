module top_module (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

reg [1:0] state;
reg [1:0] prev_state;

parameter ABOVE_S3 = 2'b00;
parameter BETWEEN_S3_S2 = 2'b01;
parameter BETWEEN_S2_S1 = 2'b10;
parameter BELOW_S1 = 2'b11;
parameter RESET_STATE = 2'b00;

always @(posedge clk) begin
  if (reset) begin
    state <= RESET_STATE;
    prev_state <= RESET_STATE;
    fr3 <= 1'b1;
    fr2 <= 1'b1;
    fr1 <= 1'b1;
    dfr <= 1'b1;
  end
  else begin
    prev_state <= state;
    case (state)
      ABOVE_S3:
        if (s == 3'b111)
          state <= ABOVE_S3;
        else if (s == 3'b110)
          state <= BETWEEN_S3_S2;
        else
          state <= BELOW_S1;
      BETWEEN_S3_S2:
        if (s == 3'b110)
          state <= BETWEEN_S3_S2;
        else if (s == 3'b100)
          state <= BETWEEN_S2_S1;
        else
          state <= ABOVE_S3;
      BETWEEN_S2_S1:
        if (s == 3'b100)
          state <= BETWEEN_S2_S1;
        else if (s == 3'b000)
          state <= BELOW_S1;
        else
          state <= BETWEEN_S3_S2;
      BELOW_S1:
        if (s == 3'b000)
          state <= BELOW_S1;
        else if (s == 3'b010)
          state <= BETWEEN_S2_S1;
        else
          state <= BETWEEN_S3_S2;
    endcase
  end
end

always @(state, prev_state) begin
  case (state)
    ABOVE_S3:
      fr1 <= 1'b0;
      fr2 <= 1'b0;
      fr3 <= 1'b0;
      dfr <= 1'b0;
    BETWEEN_S3_S2:
      fr1 <= 1'b1;
      fr2 <= 1'b0;
      fr3 <= 1'b0;
      dfr <= 1'b0;
    BETWEEN_S2_S1:
      fr1 <= 1'b1;
      fr2 <= 1'b1;
      fr3 <= 1'b0;
      if (prev_state == BETWEEN_S3_S2)
        dfr <= 1'b1;
      else
        dfr <= 1'b0;
    BELOW_S1:
      fr1 <= 1'b1;
      fr2 <= 1'b1;
      fr3 <= 1'b1;
      if (prev_state == BETWEEN_S2_S1)
        dfr <= 1'b1;
      else
        dfr <= 1'b0;
    default:
      fr1 <= 1'b1;
      fr2 <= 1'b1;
      fr3 <= 1'b1;
      dfr <= 1'b1;
  endcase
end

endmodule
