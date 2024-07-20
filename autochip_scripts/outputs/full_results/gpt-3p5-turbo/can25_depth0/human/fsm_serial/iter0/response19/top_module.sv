module top_module (
  input clk,
  input in,
  input reset,
  output done
);

  reg [2:0] state;
  reg [7:0] data;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      data <= 0;
      done <= 0;
    end
    else begin
      case (state)
        0: begin  // idle state
          if (in == 0) begin
            state <= 1;  // transition to start bit detection state
            data <= 0;
          end
        end

        1: begin  // start bit detection state
          state <= 2;  // transition to data receiving state
          data <= in;
        end

        2: begin  // data receiving state
          if (in == 0) begin
            state <= 3;  // transition to stop bit detection state
          end
          else begin
            data <= {data[6:0], in};  // shift in the next bit
          end
        end

        3: begin  // stop bit detection state
          if (in == 1) begin
            state <= 0;  // transition back to idle state
            done <= 1;  // indicate successful reception of a byte
          end
          else begin
            state <= 3;  // stay in stop bit detection state until stop bit is detected
          end
        end
      endcase
    end
  end

endmodule
