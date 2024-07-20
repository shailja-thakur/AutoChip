module top_module(
  input wire clock,
  input wire reset,
  output reg [31:0] data,
  output reg valid
);

  // Internal signals
  reg [1:0] state;
  reg [15:0] counter;

  // FSM states
  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  // Data processing logic
  always @(posedge clock, posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 0;
      data <= 0;
      valid <= 0;
    end else begin
      case (state)
        IDLE: begin
          counter <= 0;
          data <= 0;
          valid <= 0;
          state <= WAIT;
        end
        WAIT: begin
          counter <= counter + 1;
          data <= 0;
          valid <= 0;
          if (counter == 100) begin  // Change the threshold here
            state <= PROCESS;
            counter <= 0;
          end
        end
        PROCESS: begin
          data <= in;  // Input data processing logic goes here
          valid <= 1;
          state <= DONE;
        end
        DONE: begin
          valid <= 1;
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
