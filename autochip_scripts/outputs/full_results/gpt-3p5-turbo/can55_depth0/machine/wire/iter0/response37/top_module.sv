module top_module(
  input wire clk,
  input wire reset,
  output reg [7:0] data,
  output reg valid
);

  reg [1:0] state;
  reg [7:0] counter;

  // Internal signals
  reg [7:0] data_output;

  // FSM states
  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 8'd0;
      data <= 8'd0;
      valid <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          counter <= 8'd0;
          data <= 8'd0;
          valid <= 1'b0;
          if (in) begin
            state <= WAIT;
          end
        end
        WAIT: begin
          counter <= counter + 1;
          data <= 8'd0;
          valid <= 1'b0;
          if (counter == 8'd9) begin
            state <= PROCESS;
          end
        end
        PROCESS: begin
          data <= data_output;
          valid <= 1'b0;
          state <= DONE;
        end
        DONE: begin
          valid <= 1'b1;
          state <= IDLE;
        end
      endcase
    end
  end

  always @(*) begin
    case (state)
      PROCESS: begin
        // Place your processing logic here
        data_output = /* processing logic */ 8'd0;
      end
      default: begin
        data_output = 8'd0;
      end
    endcase
  end

endmodule
