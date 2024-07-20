module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

  reg [2:0] state;

  parameter IDLE_STATE = 3'b000;
  parameter START_STATE = 3'b001;
  parameter DATA_STATE = 3'b010;
  parameter STOP_STATE = 3'b011;
  parameter ERROR_STATE = 3'b100;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE_STATE;
      out_byte <= 8'h00;
      done <= 0;
    end else begin
      case (state)
        IDLE_STATE:
          if (in == 1'b0) begin
            state <= START_STATE;
            out_byte <= 8'h00;
            done <= 0;
          end
        START_STATE:
          if (in == 1'b0) begin
            state <= DATA_STATE;
            out_byte <= 8'h00;
            done <= 0;
          end else begin
            state <= ERROR_STATE;
            out_byte <= 8'h00;
            done <= 0;
          end
        DATA_STATE:
          if (in == 1'b0) begin
            out_byte <= {out_byte[6:0], in};
            done <= 0;
          end else begin
            state <= STOP_STATE;
            done <= 0;
          end
        STOP_STATE:
          if (in == 1'b1) begin
            state <= IDLE_STATE;
            done <= 1;
          end else begin
            state <= ERROR_STATE;
            out_byte <= 8'h00;
            done <= 0;
          end
        ERROR_STATE:
          if (in == 1'b1) begin
            state <= IDLE_STATE;
            done <= 0;
          end
      endcase
    end
  end
endmodule
