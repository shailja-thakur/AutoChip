module top_module(
  input wire clk,
  input wire reset,
  output reg out
);

  // internal signals
  reg [1:0] state;
  reg [15:0] counter;

  // FSM states
  localparam IDLE = 2'b00;
  localparam WAIT = 2'b01;
  localparam PROCESS = 2'b10;
  localparam DONE = 2'b11;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 0;
      out <= 0;
    end else begin
      case (state)
        IDLE:
          if (reset)
            state <= IDLE;
          else
            state <= WAIT;
        WAIT:
          if (counter == 10'b1001100110) // define the threshold value here
            state <= PROCESS;
          else
            counter <= counter + 1;
        PROCESS:
          state <= DONE;
        DONE:
          state <= IDLE;
      endcase
    end
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      out <= 0;
    else if (state == PROCESS)
      out <= in;
    else
      out <= 0;
  end

endmodule
