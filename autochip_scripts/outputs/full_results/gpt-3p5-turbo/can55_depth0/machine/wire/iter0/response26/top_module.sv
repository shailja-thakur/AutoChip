module top_module(
  input clk,
  input rst,
  output reg data_out,
  output reg valid_out
);

  reg [2:0] state;
  reg [7:0] counter;
  reg [7:0] data;
  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= 0;
      counter <= 0;
      data_out <= 0;
      valid_out <= 0;
    end else begin
      case(state)
        0: begin // idle state
          counter <= 0;
          data_out <= 0;
          if (in) begin
            state <= 1; // transition to wait state
          end
        end
        1: begin // wait state
          counter <= counter + 1;
          data_out <= 0;
          if (counter == 8'hFF) begin
            state <= 2; // transition to process state
          end
        end
        2: begin // process state
          data_out <= data;
          state <= 3; // transition to done state
        end
        3: begin // done state
          valid_out <= 1;
          state <= 0; // transition back to idle state
        end
      endcase
    end
  end
  
endmodule
