module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  reg [1:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= BYTE1;
      out_bytes <= 0;
      done <= 0;
    end
    else begin
      case (state)
        BYTE1:
          if (in[2] == 1) begin
            state <= BYTE2;
          end
          else begin
            state <= BYTE1;
          end
        BYTE2:
          if (in[2] == 1) begin
            state <= BYTE3;
          end
          else begin
            state <= BYTE1;
          end
        BYTE3:
          if (in[2] == 1) begin
            state <= DONE;
          end
          else begin
            state <= BYTE1;
          end
        DONE:
          if (in[2] == 0) begin
            state <= BYTE1;
          end
          else begin
            state <= DONE;
          end
      endcase
      
      if (state == DONE) begin
        done <= 1;
      end
      else begin
        done <= 0;
      end
      
      out_bytes <= {out_bytes[15:0], in};
    end
  end

endmodule
