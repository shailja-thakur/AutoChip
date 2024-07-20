module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] delay_counter;
  reg [3:0] remaining_time;
  reg [3:0] shift_reg;
  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counting <= 0;
      done <= 0;
      delay_counter <= 0;
      remaining_time <= 0;
      shift_reg <= 4'b0;
      state <= 3'b000;
    end else begin
      case (state)
        3'b000: begin
          if (data == 1'b1) begin
            shift_reg <= {shift_reg[2:0], data};
            if (shift_reg == 4'b1101) begin
              delay <= shift_reg[3:0];
              state <= 3'b001;
            end
          end
        end
        3'b001: begin
          counting <= 1;
          state <= 3'b010;
        end
        3'b010: begin
          if (delay_counter < (delay + 1)) begin
            delay_counter <= delay_counter + 1;
            state <= 3'b010;
          end else begin
            delay_counter <= 0;
            state <= 3'b011;
          end
        end
        3'b011: begin
          if (remaining_time < delay) begin
            remaining_time <= remaining_time + 1;
            state <= 3'b011;
          end else if (remaining_time == delay) begin
            remaining_time <= 0;
            state <= 3'b100;
          end
        end
        3'b100: begin
          counting <= 0;
          done <= 1;
          if (ack) begin
            done <= 0;
            state <= 3'b000;
          end
        end
      endcase
    end
  end

  assign count = counting ? remaining_time : 4'bXXXX;
  
endmodule
