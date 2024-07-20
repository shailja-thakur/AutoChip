module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [23:0] out_reg;
  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_reg <= 0;
      state <= BYTE1;
    end else begin
      case (state)
        BYTE1:
          if (in[2] == 1)
            state <= BYTE2;
          else
            state <= BYTE1;
        BYTE2:
          state <= BYTE3;
        BYTE3:
          if (in[2] == 0)
            state <= BYTE1;
          else
            state <= DONE;
        DONE:
          state <= BYTE1;
      endcase

      if (state == DONE)
        done <= 1;
      else
        done <= 0;

      if (state == DONE)
        out_bytes <= out_reg;
    end
  end

  always @(posedge clk) begin
    out_reg <= {out_reg[15:0], in};
  end

endmodule
