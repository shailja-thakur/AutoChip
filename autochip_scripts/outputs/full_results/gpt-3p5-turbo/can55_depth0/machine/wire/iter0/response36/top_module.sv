module top_module(
  input clk,
  input rst,
  output reg data_out,
  output reg valid);
  
  reg [1:0] state;
  reg [7:0] counter;
  
  parameter IDLE = 2'b00;
  parameter WAIT = 2'b01;
  parameter PROCESS = 2'b10;
  parameter DONE = 2'b11;
  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE;
      counter <= 8'b0;
      data_out <= 1'b0;
      valid <= 1'b0;
    end else begin
      case (state)
        IDLE: begin
          counter <= 8'b0;
          data_out <= 1'b0;
          valid <= 1'b0;
          if (in) begin
            state <= WAIT;
          end
        end
        
        WAIT: begin
          counter <= counter + 1;
          data_out <= 1'b0;
          valid <= 1'b0;
          if (counter == 8'hFF) begin
            state <= PROCESS;
          end
        end
        
        PROCESS: begin
          data_out <= in;
          valid <= 1'b1;
          state <= DONE;
        end
        
        DONE: begin
          valid <= 1'b1;
          state <= IDLE;
        end
          
        default: state <= IDLE;
      endcase
    end
  end
endmodule
