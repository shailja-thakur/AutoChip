module top_module(
  input clk,
  input reset,
  input data,
  output start_shifting);

  reg [3:0] state;
  assign start_shifting = (state == 4'b1101) ? 1'b1 : 1'b0;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 4'b0;
    else begin
      case (state)
        4'b00: begin
          if (data)
            state <= 4'b01;
          else
            state <= 4'b00;
        end
        4'b01: begin
          if (data)
            state <= 4'b11;
          else
            state <= 4'b00;
        end
        4'b11: begin
          if (data)
            state <= 4'b11;
          else
            state <= 4'b110;
        end
        4'b110: begin
          if (data)
            state <= 4'b1101;
          else
            state <= 4'b00;
        end
        4'b1101: begin
          state <= 4'b1101;
        end
      endcase
    end
  end

endmodule
