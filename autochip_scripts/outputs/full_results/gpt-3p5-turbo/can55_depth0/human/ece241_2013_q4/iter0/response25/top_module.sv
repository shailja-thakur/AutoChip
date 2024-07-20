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

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 3'b000;
    fr3 <= 1'b1;
    fr2 <= 1'b1;
    fr1 <= 1'b1;
    dfr <= 1'b1;
  end else begin
    case(state)
      3'b000:
        begin
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b1;
          if (s == 3'b111) begin
            state <= 3'b100;
          end else if (s == 3'b110) begin
            state <= 3'b010;
          end else if (s == 3'b100) begin
            state <= 3'b001;
          end
        end
        
      3'b001:
        begin
          fr3 <= 1'b0;
          fr2 <= 1'b0;
          fr1 <= 1'b0;
          dfr <= 1'b1;
          if (s == 3'b110) begin
            state <= 3'b010;
          end else if (s == 3'b100) begin
            state <= 3'b001;
          end else if (s == 3'b000) begin
            state <= 3'b000;
          end
        end
        
      3'b010:
        begin
          fr3 <= 1'b0;
          fr2 <= 1'b1;
          fr1 <= 1'b0;
          dfr <= 1'b0;
          if (s == 3'b100) begin
            state <= 3'b001;
          end else if (s == 3'b000) begin
            state <= 3'b000;
          end
        end
        
      3'b100:
        begin
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b0;
          dfr <= 1'b0;
          if (s == 3'b000) begin
            state <= 3'b000;
          end
        end
        
      default:
        state <= 3'b000;
    endcase
  end
end

endmodule
