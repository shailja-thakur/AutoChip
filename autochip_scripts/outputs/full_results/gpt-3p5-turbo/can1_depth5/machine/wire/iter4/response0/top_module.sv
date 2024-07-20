module top_module(
  input clk,
  input reset,
  input in,
  output reg out
);

  reg [1:0] state;
  reg [7:0] counter;

  // FSM states
  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 0;
      out <= 0;
    end else begin
      case (state)
        IDLE: begin
          counter <= 0;
          out <= 0;
          
          if (in == 1)
            state <= WAIT;
        end
        WAIT: begin
          counter <= counter + 1;
          out <= 0;
          
          if (counter == 4) // Adjust the threshold here
            state <= PROCESS;
        end
        PROCESS: begin
          out <= in; // Replace 'in' with the proper data being processed
          state <= DONE;
        end
        DONE: begin
          if (in == 0)
            state <= IDLE;
        end
      endcase
    end
  end

  endmodule
