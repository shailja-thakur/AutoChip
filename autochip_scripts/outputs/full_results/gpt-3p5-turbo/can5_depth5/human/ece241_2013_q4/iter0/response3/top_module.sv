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
reg s_changed;

always @(posedge clk) begin
  if (reset) begin
    s_reg <= 3'b000;
    s_changed <= 1'b0;
    fr3 <= 1'b1;
    fr2 <= 1'b1;
    fr1 <= 1'b1;
    dfr <= 1'b1;
  end else begin
    s_reg <= s;
    s_changed <= (s_reg != s);
    
    case (s_reg)
      3'b111: begin // Above s[3]
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b0;
        dfr <= 1'b0;
      end
      
      3'b110: begin // Between s[3] and s[2]
        fr3 <= 1'b0;
        fr2 <= 1'b0;
        fr1 <= 1'b1;
        dfr <= 1'b0;
      end
      
      3'b100: begin // Between s[2] and s[1]
        if (s_changed) begin
          fr3 <= 1'b0;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b0;
        end
      end
      
      default: begin // Below s[1]
        if (s_changed) begin
          fr3 <= 1'b1;
          fr2 <= 1'b1;
          fr1 <= 1'b1;
          dfr <= 1'b1;
        end
      end
    endcase
  end
end

endmodule
