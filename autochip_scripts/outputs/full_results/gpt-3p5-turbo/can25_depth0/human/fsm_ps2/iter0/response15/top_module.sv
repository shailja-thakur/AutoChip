module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  
  reg [2:0] state;
  reg [7:0] byte1, byte2, byte3;
  reg done_reg;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      byte1 <= 0;
      byte2 <= 0;
      byte3 <= 0;
      done_reg <= 0;
    end else begin
      case (state)
        0: begin // Idle state
          if (in[3] == 1) begin
            state <= 1; // Go to the Byte 1 state
            byte1 <= in;
          end
        end
        
        1: begin // Byte 1 state
          state <= 2; // Go to the Byte 2 state
          byte2 <= in;
        end
        
        2: begin // Byte 2 state
          state <= 3; // Go to the Byte 3 state
          byte3 <= in;
        end
        
        3: begin // Byte 3 state
          state <= 0; // Go back to the Idle state
          done_reg <= 1;
        end
      endcase
    end
  end
  
  assign done = done_reg;
  
endmodule
