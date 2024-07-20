module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg start;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 4'b0000;
      start <= 1'b0;
    end else begin
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
            state <= 4'b0111;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0111: begin
          if (data) begin
            start <= 1'b1;
            state <= 4'b1111;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b1111: begin
          if (reset) begin
            start <= 1'b0;
            state <= 4'b0000;
          end else begin
            state <= 4'b1111;
          end
        end
      endcase
    end
  end

  assign start_shifting = start;

endmodule
