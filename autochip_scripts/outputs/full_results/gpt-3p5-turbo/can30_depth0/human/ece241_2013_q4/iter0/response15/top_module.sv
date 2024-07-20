module top_module (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

reg [2:0] state, next_state; 

parameter
  IDLE = 3'b000,
  ABOVE_S3 = 3'b001,
  BETWEEN_S32 = 3'b010,
  BETWEEN_S21 = 3'b011,
  BELOW_S1 = 3'b100;
  
always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= IDLE;
    fr3 <= 1'b1;
    fr2 <= 1'b1;
    fr1 <= 1'b1;
    dfr <= 1'b0;
  end else begin
    state <= next_state;
    fr3 <= 1'b0;
    fr2 <= 1'b0;
    fr1 <= 1'b0;
    dfr <= 1'b0;
  end
end

always @(state or s) begin
  case (state)
    IDLE:
      if (s == 3'b100)
        next_state = BELOW_S1;
      else if (s == 3'b011)
        next_state = BETWEEN_S21;
      else if (s == 3'b010)
        next_state = BETWEEN_S32;
      else if (s == 3'b001)
        next_state = ABOVE_S3;
    ABOVE_S3:
      if (s == 3'b011)
        next_state = BETWEEN_S21;
      else if (s == 3'b010)
        next_state = BETWEEN_S32;
      else if (s == 3'b100)
        next_state = BELOW_S1;
    BETWEEN_S32:
      if (s == 3'b001)
        next_state = ABOVE_S3;
      else if (s == 3'b100)
        next_state = BELOW_S1;
    BETWEEN_S21:
      if (s == 3'b100)
        next_state = BELOW_S1;
    BELOW_S1:
      next_state = IDLE;
  endcase
end

always @(state) begin
  case (state)
    IDLE:
      begin
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
      end
    ABOVE_S3:
      begin
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b0;
        dfr <= 1'b0;
      end
    BETWEEN_S32:
      begin
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b1;
        dfr <= 1'b0;
      end
    BETWEEN_S21:
      begin
        fr3 <= 1'b0;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
      end
    BELOW_S1:
      begin
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
      end
  endcase
end

endmodule
