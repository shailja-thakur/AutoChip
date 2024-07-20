module top_module(
  input wire clk,
  input wire reset,
  output wire data_out,
  output wire valid
);
  
  reg [1:0] state;
  reg [3:0] counter;
  reg [7:0] data;
  
  // State Definitions
  localparam IDLE = 2'b00;
  localparam WAIT = 2'b01;
  localparam PROCESS = 2'b10;
  localparam DONE = 2'b11;
  
  // Outputs
  assign data_out = (state == PROCESS) ? data : 8'b0;
  assign valid = (state == DONE);
  
  // State Transition and Output Logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      counter <= 0;
      data <= 0;
    end else begin
      case (state)
        IDLE: begin
          counter <= 0;
          data <= 0;
          
          if (in) begin
            state <= WAIT;
          end
        end
        
        WAIT: begin
          counter <= counter + 1;
          data <= 0;
          
          if (counter == 4'b1111) begin
            state <= PROCESS;
          end
        end
        
        PROCESS: begin
          data <= in;
          state <= DONE;
        end
        
        DONE: begin
          state <= IDLE;
        end
      endcase
    end
  end
  
endmodule
