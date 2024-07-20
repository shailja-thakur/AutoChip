module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);

  reg [1:0] state;
  reg [7:0] byte1, byte2, byte3;
  wire is_byte1;
  
  reg [7:0] next_byte;
  wire is_next_byte1;
  
  assign is_byte1 = (state == 0) ? (in[3] == 1) : is_next_byte1;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      done <= 0;
      byte1 <= 0;
      byte2 <= 0;
      byte3 <= 0;
    end else begin
      byte1 <= (is_byte1) ? in : byte1;
      byte2 <= (state == 1) ? in : byte2;
      byte3 <= (state == 2) ? in : byte3;
      
      is_next_byte1 <= (state == 2) ? (in[3] == 1) : 0;
      
      case(state)
        0: begin
          if (is_byte1) begin
            state <= 1;
          end
        end
        1: begin
          state <= 2;
        end
        2: begin
          state <= 3;
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
