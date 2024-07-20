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
    if (reset)
      state <= 0;
    else begin
      case (state)
        3'd0:
          begin
            if (in[2] == 1)
              state <= 3'd1;
            else
              state <= 3'd0;
          end
        3'd1:
          begin
            if (in[2] == 1)
              state <= 3'd2;
            else
              state <= 3'd0;
          end
        3'd2:
          begin
            if (in[2] == 1)
              state <= 3'd3;
            else
              state <= 3'd0;
          end
        3'd3:
          begin
            if (in[2] == 0)
              state <= 3'd0;
            else
              state <= 3'd1;
          end
      endcase
    end
  end

  always @(posedge clk) begin
    if (state == 3'd3)
      done <= 1;
    else
      done <= 0;

    if (done)
      out_bytes <= out_reg;
    out_reg <= {out_reg[15:0], in};
  end

endmodule
