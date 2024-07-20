module top_module(
  input wire clk,
  input wire reset,
  output wire data_out,
  output wire valid_out
);

  reg data_out;
  reg valid_out;
  reg [1:0] state;
  reg [7:0] counter;

  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 0;
      data_out <= 0;
      valid_out <= 0;
    end else begin
      case(state)
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
            if (counter == 8'hFF) begin
              state <= PROCESS;
            end
          end

        PROCESS:
          begin
            data_out <= in;
            valid_out <= 1;
            state <= DONE;
          end

        DONE:
          begin
            valid_out <= 1;
            if (counter != 8'hFF) begin
              state <= IDLE;
            end
          end
      endcase
    end
  end

endmodule
