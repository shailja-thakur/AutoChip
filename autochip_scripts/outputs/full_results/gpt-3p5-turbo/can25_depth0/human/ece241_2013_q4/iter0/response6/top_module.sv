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
  
  always @(posedge clk) begin
    if (reset) begin
      s_reg <= 0;
      fr3 <= 1;
      fr2 <= 1;
      fr1 <= 1;
      dfr <= 0;
    end else begin
      s_reg <= s;
      
      case (s)
        3: begin
          fr1 <= 0;
          fr2 <= 0;
          fr3 <= 0;
          dfr <= 0;
        end
        2: begin
          fr1 <= 1;
          fr2 <= 1;
          fr3 <= 0;
          dfr <= 0;
        end
        1: begin
          fr1 <= 1;
          fr2 <= 1;
          fr3 <= 0;
          dfr <= 0;
          if (s_reg == 2) begin
            dfr <= 1;
          end
        end
        default: begin
          fr1 <= 1;
          fr2 <= 1;
          fr3 <= 1;
          dfr <= 0;
        end
      endcase
    end
  end
  
endmodule
