module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [1:0] state;
  reg [7:0] byte1;
  reg [7:0] byte2;
  reg [7:0] byte3;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      byte1 <= 0;
      byte2 <= 0;
      byte3 <= 0;
    end 
    else begin
      case (state)
        0: begin // Idle state
          if (in[3] == 1) begin
            byte1 <= in;
            state <= 1;
          end
        end
        
        1: begin // Receiving byte 2
          byte2 <= in;
          state <= 2;
        end
        
        2: begin // Receiving byte 3
          byte3 <= in;
          state <= 0;
        end
      endcase
    end
  end

  assign done = (state == 2);
  
endmodule
