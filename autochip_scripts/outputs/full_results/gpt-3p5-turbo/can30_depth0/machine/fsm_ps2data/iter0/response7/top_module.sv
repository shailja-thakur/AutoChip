module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  reg [1:0] state;
  reg [7:0] shift_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1;
      out_bytes <= 0;
      shift_reg <= 0;
    end else begin
      case (state)
        BYTE1:
          if (in[2]) begin
            state <= BYTE2;
          end else begin
            state <= BYTE1;
          end
        BYTE2:
          state <= BYTE3;
        BYTE3:
          state <= DONE;
        DONE:
          if (in[2]) begin
            state <= BYTE1;
          end else begin
            state <= BYTE1;
          end
      endcase
    end
  end

  always @(posedge clk) begin
    if (state == DONE) begin
      done <= 1;
      out_bytes <= shift_reg;
    end else begin
      done <= 0;
      shift_reg <= {shift_reg[15:0], in};
    end
  end

endmodule
