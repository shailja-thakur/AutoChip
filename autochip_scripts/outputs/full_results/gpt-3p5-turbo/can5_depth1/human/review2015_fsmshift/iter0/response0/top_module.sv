module top_module(
  input clk,
  input reset,
  output shift_ena);

  reg [1:0] state;
  reg [2:0] counter;

  parameter IDLE = 2'b00;
  parameter SHIFT_ENA = 2'b01;
  parameter RESET_CYCLE = 2'b10;

  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= RESET_CYCLE;
    else
      case(state)
        IDLE:
          begin
            if (<<condition to detect proper bit pattern>>)
              state <= SHIFT_ENA;
            else
              state <= IDLE;
          end

        SHIFT_ENA:
          begin
            if (counter < 3)
              state <= SHIFT_ENA;
            else
              state <= IDLE;
          end

        RESET_CYCLE:
          begin
            if (counter < 3)
              state <= RESET_CYCLE;
            else
              state <= IDLE;
          end
      endcase
  end

  always @(posedge clk)
  begin
    if (reset)
      counter <= 0;
    else
      counter <= counter + 1;
  end

  assign shift_ena = (state == SHIFT_ENA);

endmodule
