module top_module(
  input clock,
  input reset,
  output reg data,
  output reg valid);

  // Internal signals
  reg [1:0] state;
  reg [7:0] counter;

  // FSM states
  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  // Initial state and outputs
  always @(posedge reset)
  begin
    if (reset)
    begin
      state <= IDLE;
      counter <= 0;
      data <= 0;
      valid <= 0;
    end
  end

  // FSM logic
  always @(posedge clock)
  begin
    case (state)
      IDLE:
      begin
        counter <= 0;
        data <= 0;
        valid <= 0;
        if (!reset)
          state <= WAIT;
      end

      WAIT:
      begin
        counter <= counter + 1;
        data <= 0;
        valid <= 0;
        if (counter == 4'd9)
          state <= PROCESS;
      end

      PROCESS:
      begin
        data <= in;
        valid <= 0;
        state <= DONE;
      end

      DONE:
      begin
        valid <= 1;
        state <= IDLE;
      end
    endcase
  end

endmodule
