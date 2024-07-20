module top_module(
  input wire clk,
  input wire reset,
  output reg [7:0] data_out,
  output reg valid_out
);

  reg [1:0] state;
  reg [7:0] counter;

  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 8'h00;
      data_out <= 8'h00;
      valid_out <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          counter <= 8'h00;
          data_out <= 8'h00;
          valid_out <= 1'b0;
          
          if (in) begin
            state <= WAIT;
          end
        end
        WAIT: begin
          counter <= counter + 1;
          data_out <= 8'h00;
          valid_out <= 1'b0;
          
          if (counter == 8'hFF) begin
            state <= PROCESS;
          end
        end
        PROCESS: begin
          data_out <= in;
          state <= DONE;
        end
        DONE: begin
          valid_out <= 1'b1;
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
