module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  reg [2:0] state;
  reg [23:0] shift_reg;
  
  always @(posedge clk) begin
    if (reset == 1) begin
      state <= 3'b000;
      shift_reg <= 0;
      done <= 0;
    end else begin
      case (state)
        3'b000:
          if (in[2] == 1)
            state <= 3'b001;
          else
            state <= 3'b000;
            
        3'b001:
          if (in[2] == 1)
            state <= 3'b010;
          else
            state <= 3'b000;
            
        3'b010:
          if (in[2] == 1)
            state <= 3'b100;
          else
            state <= 3'b000;
            
        3'b100:
          if (in[2] == 0)
            state <= 3'b000;
          else
            state <= 3'b100;
      endcase
      
      if (state == 3'b100)
        done <= 1;
      else
        done <= 0;
        
      if (done == 1)
        out_bytes <= shift_reg;
        
      shift_reg <= {shift_reg[15:0], in};
    end
  end
endmodule
