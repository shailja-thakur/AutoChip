module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [7:0] byte1;
  reg [7:0] byte2;
  reg [7:0] byte3;
  reg [7:0] buffer;

  reg state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      byte1 <= 0;
      byte2 <= 0;
      byte3 <= 0;
      buffer <= 0;
      out_bytes <= 0;
      done <= 0;
    end else begin
      case (state)
        0: begin
          if (in[3]) begin
            byte1 <= in;
            state <= 1;
          end
        end
        1: begin
          byte2 <= in;
          state <= 2;
        end
        2: begin
          byte3 <= in;
          state <= 3;
        end
        3: begin
          buffer <= byte1;
          buffer <= buffer << 8;
          buffer <= buffer | byte2;
          buffer <= buffer << 8;
          buffer <= buffer | byte3;
          out_bytes <= buffer;
          done <= 1;
          state <= 0;
        end
      endcase
    end
  end

endmodule
