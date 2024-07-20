module top_module(
  input wire clk,
  input wire rst,
  output wire data,
  output wire valid);

  reg [1:0] state;
  reg [7:0] counter;
  reg [7:0] data ;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= 2'b00;
      counter <= 8'b0;
      data <= 8'b0;
      valid <= 1'b0;
    end else begin
      case (state)
        2'b00: begin // idle state
          counter <= 8'b0;
          data <= 8'b0;
          valid <= 1'b0;
          if (in) begin
            state <= 2'b01; // transition to wait state
          end
        end
        2'b01: begin // wait state
          counter <= counter + 1;
          data <= 8'b0;
          valid <= 1'b0;
          if (counter == 8'hFF) begin
            state <= 2'b10; // transition to process state
          end
        end
        2'b10: begin // process state
          data <= in;
          state <= 2'b11; // transition to done state
        end
        2'b11: begin // done state
          valid <= 1'b1;
          state <= 2'b00; // transition back to idle state
        end
      endcase
    end
  end

endmodule
