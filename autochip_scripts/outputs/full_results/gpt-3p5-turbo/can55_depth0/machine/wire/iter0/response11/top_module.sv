module top_module(
  input wire clk,
  input wire rst,
  output wire data_out,
  output wire valid_out);
  
  reg [1:0] state;
  reg [3:0] counter;
  reg [1:0] data_out;
  
  always @(posedge clk or posedge rst)
  begin
    if (rst)
    begin
      state <= 2'b00; // idle state
      counter <= 0;
      data_out <= 2'b00;
    end
    else
    begin
      case (state)
        2'b00: // idle state
        begin
          counter <= 0;
          data_out <= 2'b00;
          state <= 2'b01; // wait state
        end
        2'b01: // wait state
        begin
          counter <= counter + 1;
          data_out <= 2'b00;
          if (counter == 4'd9) // threshold value
            state <= 2'b10; // process state
        end
        2'b10: // process state
        begin
          data_out <= in;
          state <= 2'b11; // done state
        end
        2'b11: // done state
        begin
          data_out <= in;
          valid_out <= 1;
          state <= 2'b00; // idle state
        end
      endcase
    end
  end
  
endmodule
