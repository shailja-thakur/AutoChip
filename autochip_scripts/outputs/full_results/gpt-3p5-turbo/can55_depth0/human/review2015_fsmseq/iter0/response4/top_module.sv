module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting
);

  reg [3:0] state;

  always@(posedge clk or posedge reset) begin
    if (reset)
      state <= 4'b0000;
    else begin
      case (state)
        4'b0000: begin
          if (data) begin
            state <= 4'b0001;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0001: begin
          if (data) begin
            state <= 4'b0011;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0011: begin
          if (data) begin
            state <= 4'b0101;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0101: begin
          if (data) begin
            start_shifting <= 1;
            state <= 4'b0101;
          end else begin
            state <= 4'b0000;
          end
        end
      endcase
    end
  end

endmodule
