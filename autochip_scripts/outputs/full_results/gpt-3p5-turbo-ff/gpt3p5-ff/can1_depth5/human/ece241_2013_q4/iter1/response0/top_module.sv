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
// State Definitions
parameter S_Above_s3 = 3'b000;
parameter S_Between_s3_s2 = 3'b001;
parameter S_Between_s2_s1 = 3'b010;
parameter S_Below_s1 = 3'b011;
  
always @(posedge clk) begin
    if (reset == 1'b1) begin
      state <= S_Below_s1;
      fr3 <= 1'b1;
      fr2 <= 1'b1;
      fr1 <= 1'b1;
      dfr <= 1'b1;
    end else begin
      case(state)
          S_Above_s3: begin
              fr3 <= 1'b0;
              fr2 <= 1'b0;
              fr1 <= 1'b0;
              dfr <= 1'b0;
              if (s >= 3'b001) begin
                  state <= S_Between_s3_s2;
              end
          end
          S_Between_s3_s2: begin
              fr3 <= 1'b0;
              fr2 <= 1'b0;
              fr1 <= 1'b1;
              dfr <= 1'b0;
              if (s >= 3'b010) begin
                  state <= S_Between_s2_s1;
              end
              if (s <= 3'b000) begin
                  state <= S_Above_s3;
              end
          end
          S_Between_s2_s1: begin
              fr3 <= 1'b0;
              fr2 <= 1'b1;
              fr1 <= 1'b1;
              dfr <= 1'b0;
              if (s <= 3'b001) begin
                  state <= S_Between_s3_s2;
              end
              if (s <= 3'b000) begin
                  state <= S_Above_s3;
              end
          end
          S_Below_s1: begin
              fr3 <= 1'b1;
              fr2 <= 1'b1;
              fr1 <= 1'b1;
              dfr <= 1'b1;
              if (s >= 3'b001) begin
                  state <= S_Between_s3_s2;
              end
              if (s >= 3'b010) begin
                  state <= S_Between_s2_s1;
              end
              if (s >= 3'b011) begin
                  state <= S_Above_s3;
              end
          end
      endcase
    end
end

endmodule
