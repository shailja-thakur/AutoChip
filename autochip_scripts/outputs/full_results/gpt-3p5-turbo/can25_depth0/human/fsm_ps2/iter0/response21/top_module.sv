module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [2:0] state;
  reg [7:0] byte1;
  reg [7:0] byte2;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      byte1 <= 8'b0;
      byte2 <= 8'b0;
      done <= 0;
    end else begin
      case (state)
        0: begin
          if (in[3]) begin
            state <= 1;
            byte1 <= in;
          end
        end
        1: begin
          state <= 2;
          byte2 <= in;
        end
        2: begin
          state <= 0;
          done <= 1;
          byte1 <= in;
        end
        default: begin
          state <= 0;
        end
      endcase
    end
  end
  
endmodule
