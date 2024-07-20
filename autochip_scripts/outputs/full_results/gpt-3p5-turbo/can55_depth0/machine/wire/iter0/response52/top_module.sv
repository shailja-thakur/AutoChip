module top_module(
  input wire clk,
  input wire rst,
  output reg out,
  output reg valid
);

  reg [1:0] state;
  reg [7:0] counter;
  reg [7:0] data;

  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      counter <= 8'd0;
      data <= 8'd0;
      out <= 1'b0;
      valid <= 1'b0;
    end
    else begin
      case (state)
        IDLE: begin
          counter <= 8'd0;
          data <= 8'd0;
          out <= 1'b0;
          valid <= 1'b0;
          
          if (in) begin
            state <= WAIT;
          end
        end
       
        WAIT: begin
          counter <= counter + 1;
          out <= 1'b0;
          valid <= 1'b0;
          
          if (counter == 8'd10) begin
            state <= PROCESS;
          end
        end
       
        PROCESS: begin
          out <= data;
          valid <= 1'b1;
          state <= DONE;
        end
       
        DONE: begin
          out <= 1'b0;
          valid <= 1'b1;
          state <= IDLE;
        end       
      endcase
    end
  end

endmodule
