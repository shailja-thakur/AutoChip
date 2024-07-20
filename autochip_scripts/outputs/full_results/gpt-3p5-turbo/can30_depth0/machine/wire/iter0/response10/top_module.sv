module top_module(
  input wire clk,
  input wire reset,
  output reg out_valid,
  output reg [7:0] out_data
);

  reg [1:0] state;
  reg [7:0] counter;

  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  always @(posedge clk) begin
    if (reset) begin
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
          if (counter >= 5) begin
            state <= PROCESS;
          end
        end
        PROCESS: begin
          out_data <= in;
          out_valid <= 1;
          state <= DONE;
        end
        DONE: begin
          out_data <= in;
          out_valid <= 1;
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
