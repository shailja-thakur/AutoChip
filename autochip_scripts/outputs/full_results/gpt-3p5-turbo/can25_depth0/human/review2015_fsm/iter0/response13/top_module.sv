module top_module(
  input clk,
  input reset,
  input data,
  output reg shift_ena,
  output reg counting,
  input done_counting,
  output reg done,
  input ack );
  
  reg [1:0] state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00; // set state to initial state
      shift_ena <= 0;
      counting <= 0;
      done <= 0;
    end else begin
      case (state)
        2'b00: begin // search for start sequence
          if (data) begin
            state <= 2'b01;
          end
        end
        2'b01: begin // check for start sequence
          if (data) begin
            state <= 2'b10;
            shift_ena <= 1;
          end else begin
            state <= 2'b00;
          end
        end
        2'b10: begin // shift in 4 more bits and wait for counters
          shift_ena <= 1;
          counting <= 1;
          
          if (done_counting) begin
            state <= 2'b11; // indicate done counting
          end
        end
        2'b11: begin // wait for user acknowledgement
          done <= 1;
          
          if (ack) begin
            state <= 2'b00; // reset to initial state
          end
        end
        default: begin
          state <= 2'b00; // reset to initial state
        end
      endcase
    end
  end
endmodule
