module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

  reg [1:0] Y1_reg, Y3_reg;
  always @(y) begin
    case (y)
      6'b000001: begin  // State A
        Y1_reg <= 2'b0;
        Y3_reg <= 2'b0;
      end
      
      6'b000010: begin  // State B
        Y1_reg <= 2'b1;
        Y3_reg <= 2'b0;
      end
      
      6'b000100: begin  // State C
        Y1_reg <= 2'b0;
        Y3_reg <= 2'b1;
      end
      
      6'b001000: begin  // State D
        Y1_reg <= 2'b1;
        Y3_reg <= 2'b1;
      end
      
      6'b010000: begin  // State E
        Y1_reg <= 2'b0;
        Y3_reg <= 2'b0;
      end
      
      6'b100000: begin  // State F
        Y1_reg <= 2'b1;
        Y3_reg <= 2'b1;
      end
      
      default: begin
        Y1_reg <= 2'b0;
        Y3_reg <= 2'b0;
      end
    endcase
  end

  assign Y1 = Y1_reg[1];
  assign Y3 = Y3_reg[1];

endmodule
