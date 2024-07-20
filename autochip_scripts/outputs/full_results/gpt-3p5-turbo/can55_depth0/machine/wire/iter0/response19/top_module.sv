module top_module(
  input clk,
  input reset,
  output reg data_out,
  output reg valid_out );

  reg [1:0] state;
  reg [7:0] counter;

  parameter IDLE = 0;
  parameter WAIT = 1;
  parameter PROCESS = 2;
  parameter DONE = 3;

  always @(posedge clk) begin
    if (reset)
      state <= IDLE;
    else begin
      case (state)
        IDLE:
          begin
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
            state <= WAIT;
          end
        WAIT:
          begin
            counter <= counter + 1;
            data_out <= 0;
            valid_out <= 0;
            if (counter == 8'd10)
              state <= PROCESS;
          end
        PROCESS:
          begin
            data_out <= in;
            state <= DONE;
          end
        DONE:
          begin
            valid_out <= 1;
            state <= IDLE;
          end
      endcase
    end
  end
endmodule
