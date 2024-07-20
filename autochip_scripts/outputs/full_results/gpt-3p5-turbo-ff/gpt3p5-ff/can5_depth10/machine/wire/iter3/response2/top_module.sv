module top_module(
  input in,
  output reg out,
  input clk,
  input reset,
  output reg data_output,
  output reg valid_output
);

  reg [1:0] state;
  reg [7:0] counter;

  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= IDLE;
    else begin
      case (state)
        IDLE: begin
          counter <= 0;
          data_output <= 0;
          valid_output <= 0;
          if (in)
            state <= WAIT;
        end
        WAIT: begin
          counter <= counter + 1;
          data_output <= 0;
          valid_output <= 0;
          if (counter == 10)
            state <= PROCESS;
        end
        PROCESS: begin
          data_output <= in;
          state <= DONE;
        end
        DONE: begin
          valid_output <= 1;
          state <= IDLE;
        end
        default: state <= IDLE;
      endcase
    end
  end

  always @(posedge clk) begin
    case (state)
      IDLE: begin
        out <= 0;
      end
      WAIT: begin
        out <= 0;
      end
      PROCESS: begin
        out <= 1;
      end
      DONE: begin
        out <= 0;
      end
      default: begin
        out <= 0;
      end
    endcase
  end

endmodule
