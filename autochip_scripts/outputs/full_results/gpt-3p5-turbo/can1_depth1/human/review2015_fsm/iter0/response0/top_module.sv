module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack );

  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000;
    else begin
      case (state)
        3'b000: begin
          if (data == 4'b1101)
            state <= 3'b001;
          else
            state <= 3'b000;
        end
        3'b001: begin
          shift_ena <= 1;
          state     <= 3'b010;
        end
        3'b010: begin
          shift_ena <= 0;
          counting  <= 1;
          if (done_counting)
            state <= 3'b011;
          else
            state <= 3'b010;
        end
        3'b011: begin
          done <= 1;
          if (ack)
            state <= 3'b000;
          else
            state <= 3'b011;
        end
      endcase
    end
  end

endmodule
