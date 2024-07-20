module top_module(
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state, next_state;
  reg out_reg;

  parameter IDLE = 2'b00;
  parameter PROCESS = 2'b01;
  parameter FINISH = 2'b10;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= IDLE;
    else
      state <= next_state;
  end

  always @(state or in) begin
    case (state)
      IDLE:
        begin
          if (in)
            next_state = PROCESS;
          else
            next_state = PROCESS;
          out_reg = 0;
        end
      PROCESS:
        begin
          if (in)
            next_state = FINISH;
          else
            next_state = PROCESS;
          out_reg = 0;
        end
      FINISH:
        begin
          if (in)
            next_state = IDLE;
          else
            next_state = FINISH;
          out_reg = 0;
        end
    endcase
  end

  always @(posedge clk) begin
    out <= out_reg;
  end

endmodule
