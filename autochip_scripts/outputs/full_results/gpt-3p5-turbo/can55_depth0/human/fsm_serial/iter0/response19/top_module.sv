module top_module (
  input clk,
  input in,
  input reset,
  output done
);

  reg [3:0] state;
  reg [7:0] data;
  reg start_bit_detected;
  reg stop_bit_detected;

  parameter IDLE = 0;
  parameter START_BIT = 1;
  parameter RECEIVE_DATA = 2;
  parameter STOP_BIT = 3;

  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      data <= 8'd0;
      start_bit_detected <= 1'b0;
      stop_bit_detected <= 1'b0;
    end else begin
      case (state)
        IDLE:
        begin
          if (in == 1'b0)
            state <= START_BIT;
        end

        START_BIT:
        begin
          if (in == 1'b1)
            state <= RECEIVE_DATA;
        end

        RECEIVE_DATA:
        begin
          data <= {data[6:0], in};
          if (stop_bit_detected)
            state <= IDLE;
          else if (start_bit_detected && data == 8'b11111111)
            state <= STOP_BIT;
        end

        STOP_BIT:
        begin
          if (in == 1'b1)
            stop_bit_detected <= 1'b1;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (reset)
      done <= 1'b0;
    else if (state == STOP_BIT && stop_bit_detected)
      done <= 1'b1;
    else
      done <= 1'b0;
  end

endmodule
