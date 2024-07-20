module top_module(
  input wire clk,
  input wire rst,
  output reg out_data,
  output reg out_valid
);

  reg [1:0] state;
  reg [7:0] counter;

  // FSM states
  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      counter <= 0;
      out_data <= 0;
      out_valid <= 0;
    end else begin
      case (state)
        IDLE: begin
          counter <= 0;
          out_data <= 0;
          out_valid <= 0;
          if (in) begin
            state <= WAIT;
          end
        end
        WAIT: begin
          counter <= counter + 1;
          out_data <= 0;
          out_valid <= 0;
          if (counter == 7) begin // Set the threshold value here
            state <= PROCESS;
          end
        end
        PROCESS: begin
          out_data <= in;
          out_valid <= 1;
          state <= DONE;
        end
        DONE: begin
          out_valid <= 1;
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
