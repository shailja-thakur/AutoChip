module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack );

  reg [3:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 4'b0000;
    end else begin
      case(state)
        4'b0000: begin // Searching for start pattern
          if (data == 4'b1101) begin
            state <= 4'b0001;
            shift_ena <= 1;
            counting <= 0;
          end
        end
        4'b0001: begin // Wait for shift_ena cycles
          if (shift_ena < 4) begin
            shift_ena <= shift_ena + 1;
          end else begin
            state <= 4'b0010;
            counting <= 1;
          end
        end
        4'b0010: begin // Wait for done_counting
          if (done_counting) begin
            state <= 4'b0011;
            done <= 1;
          end
        end
        4'b0011: begin // Wait for ack
          if (ack) begin
            state <= 4'b0000;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
          end
        end
        default: state <= 4'b0000;
      endcase
    end
  end

endmodule
