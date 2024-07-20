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
  reg [3:0] count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      count <= 4'b0000;
      shift_ena <= 1'b0;
      counting <= 1'b0;
      done <= 1'b0;
    end else begin
      case (state)
        3'b000: begin
          if (data == 1'b1) begin
            state <= 3'b001;
            count <= 4'b0000;
          end
        end
        3'b001: begin
          shift_ena <= 1'b1;
          count <= count + 1'b1;
          if (count == 4'b0111) begin
            state <= 3'b010;
            count <= 4'b0000;
          end
        end
        3'b010: begin
          shift_ena <= 1'b0;
          counting <= 1'b1;
          if (done_counting) begin
            state <= 3'b011;
            count <= 4'b0000;
          end
        end
        3'b011: begin
          done <= 1'b1;
          if (ack) begin
            state <= 3'b000;
            count <= 4'b0000;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
          end
        end
      endcase
    end
  end

endmodule
