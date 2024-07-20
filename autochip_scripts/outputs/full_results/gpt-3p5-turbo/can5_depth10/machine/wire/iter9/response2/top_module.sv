module top_module(
  input clk,
  input reset,
  input in,
  output reg out
);

  reg [1:0] state;
  reg [7:0] counter;
  reg [7:0] data_out;
  reg valid_out;

  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= IDLE;
    else begin
      case(state)
        IDLE: begin
          counter <= 8'b0;
          data_out <= 8'b0;
          state <= WAIT;
        end
        WAIT: begin
          counter <= counter + 1;
          data_out <= 8'b0;
          if (counter == 8'd10)
            state <= PROCESS;
        end
        PROCESS: begin
          data_out <= in; // Process input 'in'
          state <= DONE;
        end
        DONE: begin
          data_out <= in;
          valid_out <= 1;
          state <= IDLE;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (valid_out) begin
      out <= data_out;
      valid_out <= 0;
    end
  end

endmodule
