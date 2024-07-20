module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] counter;
  reg [3:0] remaining_time;
  reg [3:0] shift_reg;
  wire start_sequence;

  // Detect start sequence 1101
  always @(posedge clk) begin
    if (reset) begin
      shift_reg <= 4'b0;
      start_sequence <= 0;
    end
    else begin
      shift_reg <= {shift_reg[2:0], data};
      start_sequence <= (shift_reg == 4'b1101);
    end
  end

  // Shift in delay bits
  always @(posedge clk) begin
    if (reset) begin
      delay <= 4'b0;
      counting <= 0;
      counter <= 4'b0;
      done <= 0;
      count <= 4'b0;
      remaining_time <= 4'b0;
    end
    else if (start_sequence && !counting) begin
      delay <= {data, shift_reg[3:1]};
      counting <= 1;
      counter <= delay;
      count <= delay;
      remaining_time <= delay;
    end
    else if (counting) begin
      counter <= counter - 1;
      remaining_time <= counter;
      if (counter == 4'b0) begin
        counting <= 0;
        done <= 1;
      end
    end
  end

  // Reset on ack
  always @(posedge clk) begin
    if (reset) begin
      shift_reg <= 4'b0;
    end
    else if (done && ack) begin
      shift_reg <= 4'b0;
      done <= 0;
    end
  end

endmodule
