module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  reg [7:0] state;

  always @(posedge clk) begin
    if (reset) begin
      state <= BYTE1;
      done <= 0;
      out_bytes <= 0;
    end else begin
      case (state)
        BYTE1: begin
          if (in[2] == 1) begin
            state <= BYTE2;
            out_bytes <= {out_bytes[15:0], in};
          end else begin
            state <= BYTE1;
            out_bytes <= {out_bytes[15:0], in};
          end
        end
        BYTE2: begin
          if (in[2] == 1) begin
            state <= BYTE3;
            out_bytes <= {out_bytes[7:0], in};
          end else begin
            state <= BYTE1;
            out_bytes <= {out_bytes[7:0], in};
          end
        end
        BYTE3: begin
          if (in[2] == 1) begin
            state <= DONE;
            done <= 1;
            out_bytes <= {out_bytes[7:0], in};
          end else begin
            state <= BYTE1;
            out_bytes <= {out_bytes[7:0], in};
          end
        end
        DONE: begin
          if (in[2] == 0) begin
            state <= BYTE1;
            done <= 0;
            out_bytes <= {out_bytes[7:0], in};
          end else begin
            state <= DONE;
            out_bytes <= {out_bytes[7:0], in};
          end
        end
      endcase
    end
  end

endmodule
