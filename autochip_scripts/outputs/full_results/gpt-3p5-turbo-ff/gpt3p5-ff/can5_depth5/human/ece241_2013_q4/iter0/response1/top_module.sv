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
reg fr1_temp, fr2_temp, fr3_temp;
reg dfr_temp;

always @(posedge clk or posedge reset) begin 
  if (reset)
    state <= 3'b000;
  else 
    case (state)
      3'b000: begin
        fr1 <= 1'b1;
        fr2 <= 1'b1;
        fr3 <= 1'b1;
        dfr <= 1'b0;
        if (s[3])
          state <= 3'b100;
        else if (s[2])
          state <= 3'b010;
        else if (s[1])
          state <= 3'b001;
        else
          state <= 3'b000;
      end
      3'b001: begin
        fr1 <= 1'b1;
        fr2 <= 1'b1;
        fr3 <= 1'b0;
        dfr <= 1'b0;
        if (s[3])
          state <= 3'b100;
        else if (s[2])
          state <= 3'b010;
        else if (!s[1])
          state <= 3'b000;
        else
          state <= 3'b001;
      end
      3'b010: begin
        fr1 <= 1'b1;
        fr2 <= 1'b0;
        fr3 <= 1'b0;
        dfr <= 1'b0;
        if (s[3])
          state <= 3'b100;
        else if (!s[2])
          state <= 3'b000;
        else
          state <= 3'b010;
      end
      3'b100: begin
        fr1 <= 1'b0;
        fr2 <= 1'b0;
        fr3 <= 1'b0;
        dfr <= 1'b0;
        if (!s[3])
          state <= 3'b000;
        else
          state <= 3'b100;
      end
    endcase
  end

always @(posedge clk) begin
  if (state == 3'b000 && reset)
    dfr_temp <= 1'b0;
  else
    dfr_temp <= dfr;
end

always @(posedge clk) begin
  if (state == 3'b000 && reset)
    fr3_temp <= 1'b1;
  else
    fr3_temp <= fr3;
end

always @(posedge clk) begin
  if (state == 3'b000 && reset)
    fr2_temp <= 1'b1;
  else
    fr2_temp <= fr2;
end

always @(posedge clk) begin
  if (state == 3'b000 && reset)
    fr1_temp <= 1'b1;
  else
    fr1_temp <= fr1;
end

assign dfr = dfr_temp;
assign fr3 = fr3_temp;
assign fr2 = fr2_temp;
assign fr1 = fr1_temp;

endmodule
