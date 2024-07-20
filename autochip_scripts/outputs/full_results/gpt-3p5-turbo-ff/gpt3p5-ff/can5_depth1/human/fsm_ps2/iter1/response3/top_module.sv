module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  reg [1:0] state;
  reg [7:0] byte1, byte2, byte3;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      done <= 0;
      byte1 <= 0;
      byte2 <= 0;
      byte3 <= 0;
    end else begin
      case(state)
        0: begin
          if (in[3] == 1) begin
            state <= 1;
            byte1 <= in;
          end
        end
        1: begin
          state <= 2;
          byte2 <= in;
        end
        2: begin
          state <= 3;
          byte3 <= in;
        end
        3: begin
          state <= 0;
          done <= 1;
          
          // Process the received message and perform any necessary operations
          // ...
        end
      endcase
    end
  end
  
endmodule
