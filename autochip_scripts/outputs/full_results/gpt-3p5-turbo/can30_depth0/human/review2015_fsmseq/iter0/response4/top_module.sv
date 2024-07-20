module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 4'b0000;
      start_shifting <= 0;
    end else begin
      case (state)
        4'b0000: begin
          if (data)
            state <= 4'b0001;
          else
            state <= 4'b0000;
        end
        4'b0001: begin
          if (data)
            state <= 4'b0011;
          else
            state <= 4'b0000;
        end
        4'b0011: begin
          if (data)
            state <= 4'b0110;
          else
            state <= 4'b0000;
        end
        4'b0110: begin
          if (data)
            state <= 4'b1101;
          else
            state <= 4'b0000;
        end
        4'b1101: begin
          start_shifting <= 1;
          state <= 4'b1101;
        end
      endcase
    end
  end

endmodule
