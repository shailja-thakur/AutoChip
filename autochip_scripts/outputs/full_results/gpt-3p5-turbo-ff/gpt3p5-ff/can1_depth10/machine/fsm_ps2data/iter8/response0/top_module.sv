module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  reg [3:0] state;
  reg [23:0] shift_reg;
  
  always @(posedge clk) begin
    if (reset == 1) begin
      state <= 4'b0000;
      shift_reg <= 0;
      done <= 0;
    end else begin
      case (state)
        4'b0000:
          if (in[2] == 1)
            state <= 4'b0001;
          else
            state <= 4'b0000;
            
        4'b0001:
          if (in[2] == 1)
            state <= 4'b0010;
          else if (in[2] == 0)
            state <= 4'b0000;
          else
            state <= 4'b0001;
            
        4'b0010:
          if (in[2] == 1)
            state <= 4'b0100;
          else if (in[2] == 0)
            state <= 4'b0000;
          else
            state <= 4'b0010;
            
        4'b0100:
          if (in[2] == 0)
            state <= 4'b0000;
          else
            state <= 4'b0100;
      endcase
      
      if (state == 4'b0100)
        done <= 1;
      else
        done <= 0;
        
      if (done == 1)
        out_bytes <= shift_reg;
        
      shift_reg <= {in, shift_reg[23:8]};
    end
  end
endmodule
