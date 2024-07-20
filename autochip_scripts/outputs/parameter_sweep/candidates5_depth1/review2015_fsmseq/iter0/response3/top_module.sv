module top_module(
  input clk,
  input reset,
  input data,
  output reg start_shifting);

  reg [3:0] state;
  reg shift_enable;

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= 4'b0000;
      start_shifting <= 0;
    end else begin
      case (state)
        4'b0000: begin // S0
          if (data) begin
            state <= 4'b0001;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0001: begin // S1
          if (data) begin
            state <= 4'b0011;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0011: begin // S2
          if (data) begin
            state <= 4'b0001;
          end else begin
            state <= 4'b0100;
          end
        end
        4'b0100: begin // S3
          if (data) begin
            state <= 4'b0001;
            start_shifting <= 1;
          end else begin
            state <= 4'b0000;
          end
        end
        default: state <= 4'b0000;
      endcase
    end
  end
endmodule
