module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [2:0] state;
  reg [3:0] counter;

  // state machine states
  localparam IDLE = 3'b000;
  localparam DETECTED = 3'b001;
  localparam SHIFT_IN = 3'b010;
  localparam COUNTING = 3'b011;
  localparam DONE = 3'b100;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counting <= 0;
      done <= 0;
      delay <= 0;
      counter <= 0;
      count <= 0;
    end else begin
      case(state)
        IDLE:
          if (data == 1'b1) begin
            state <= DETECTED;
            counter <= 0;
          end else begin
            state <= IDLE;
          end
        DETECTED:
          if (counter == 2) begin
            state <= SHIFT_IN;
            delay <= data;
            counter <= 0;
          end else begin
            counter <= counter + 1;
          end
        SHIFT_IN:
          if (counter == 2) begin
            state <= COUNTING;
            counting <= 1;
            counter <= 0;
          end else begin
            counter <= counter + 1;
          end
        COUNTING:
          if (counter == ((delay + 1) * 1000 - 1)) begin
            state <= DONE;
            counting <= 0;
            done <= 1;
            counter <= 0;
          end else begin
            counter <= counter + 1;
          end
        DONE:
          if (ack == 1'b1) begin
            state <= IDLE;
            done <= 0;
          end else begin
            state <= DONE;
          end
      endcase
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      count <= 0;
    end else begin
      if (counting) begin
        if (counter < delay) begin
          count <= delay - counter;
        end else begin
          count <= 0;
        end
      end else begin
        count <= 4'bxxxx;
      end
    end
  end

endmodule
