module top_module(
  input wire clk,
  input wire reset,
  output reg [7:0] data_output,
  output reg valid_output
);
 
  reg [1:0] state;
  reg [7:0] counter;
 
  // States
  localparam IDLE = 2'b00;
  localparam WAIT = 2'b01;
  localparam PROCESS = 2'b10;
  localparam DONE = 2'b11;
 
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 8'd0;
      data_output <= 8'd0;
      valid_output <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          counter <= 8'd0;
          data_output <= 8'd0;
          valid_output <= 1'b0;
          if (in) begin
            state <= WAIT;
          end
        end
        WAIT: begin
          counter <= counter + 1;
          data_output <= 8'd0;
          valid_output <= 1'b0;
          if (counter == 8'd10) begin
            state <= PROCESS;
          end
        end
        PROCESS: begin
          data_output <= in;
          valid_output <= 1'b1;
          state <= DONE;
        end
        DONE: begin
          valid_output <= 1'b1;
          state <= IDLE;
        end
        default: begin
          state <= IDLE;
          data_output <= 8'd0;
          valid_output <= 1'b0;
        end
      endcase
    end
  end
 
endmodule
