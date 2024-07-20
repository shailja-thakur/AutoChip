module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  reg [7:0] state;
  reg [23:0] shift_reg;
  
  always @(posedge clk) begin
    if (reset == 1) begin
      state <= BYTE1;
      shift_reg <= 0;
      done <= 0;
    end else begin
      case (state)
        BYTE1:
          if (in[2] == 1)
            state <= BYTE2;
          else
            state <= BYTE1;
            
        BYTE2:
          if (in[2] == 1)
            state <= BYTE3;
          else
            state <= BYTE1;
            
        BYTE3:
          if (in[2] == 1)
            state <= DONE;
          else
            state <= BYTE1;
            
        DONE:
          if (in[2] == 0)
            state <= BYTE1;
          else
            state <= DONE;
      endcase
      
      if (state == DONE)
        done <= 1;
      else
        done <= 0;
        
      shift_reg <= {shift_reg[15:0], in};
      
      if (done == 1)
        out_bytes <= shift_reg;
    end
  end
endmodule
