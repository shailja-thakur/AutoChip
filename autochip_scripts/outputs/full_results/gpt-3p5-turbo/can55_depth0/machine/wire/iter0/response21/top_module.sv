module top_module(
  input wire clock,
  input wire reset,
  output reg data_output,
  output reg valid_output
);

  // Internal signals
  reg [1:0] state;
  reg [7:0] counter;

  // FSM states
  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  // Module inputs
  input module_input;

  // Module outputs
  output reg module_output;

  // Initialize internal signals and outputs
  always @(posedge clock, posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 0;
      data_output <= 0;
      valid_output <= 0;
    end else begin
      case (state)
        IDLE: begin
          data_output <= 0;
          if (clock) begin
            state <= WAIT;
            counter <= 0;
          end
        end
        WAIT: begin
          data_output <= 0;
          counter <= counter + 1;
          if (counter == 8) begin
            state <= PROCESS;
            counter <= 0;
          end
        end
        PROCESS: begin
          data_output <= module_input;
          state <= DONE;
        end
        DONE: begin
          valid_output <= 1;
          state <= IDLE;
        end
      endcase
    end
  end
endmodule
