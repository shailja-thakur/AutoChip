module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [23:0] out_reg;  // Output register
  reg [2:0] state;     // State register

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_reg <= 0;
      state <= 0;
      done <= 0;
    end else begin
      case (state)
        0: begin // BYTE1 state
          if (in[2] == 1) begin
            state <= 1; // Transition to BYTE2
          end else begin
            state <= 0; // Transition to BYTE1
          end
        end
        1: begin // BYTE2 state
          state <= 2; // Transition to BYTE3
        end
        2: begin // BYTE3 state
          state <= 3; // Transition to DONE
        end
        3: begin // DONE state
          if (in[2] == 0) begin
            state <= 0; // Transition to BYTE1
          end else begin
            state <= 3; // Stay in DONE
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case (state)
      0: begin // BYTE1 state
        out_reg <= in;
      end
      1: begin // BYTE2 state
        out_reg <= (out_reg << 8) | in;
      end
      2: begin // BYTE3 state
        out_reg <= (out_reg << 8) | in;
      end
      3: begin // DONE state
        out_bytes <= out_reg;
      end
    endcase
  end

  assign done = (state == 3);

endmodule
