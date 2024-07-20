module top_module(
  input wire in,
  output reg out,
  input wire clk,
  input wire rst
);

  reg [1:0] state;
  reg [7:0] counter;

  always @(posedge clk) begin
    if (rst) begin
      state <= 2'b00; //idle state
      counter <= 8'd0;
      out <= 1'b0;
    end else begin
      case (state)
        2'b00: begin //idle state
          counter <= 8'd0;
          out <= 1'b0;
          state <= in ? 2'b01 : 2'b00; //transition to wait state if input is high
        end
        2'b01: begin //wait state
          counter <= counter + 1;
          out <= 1'b0;
          state <= (counter == 8'd5) ? 2'b10 : 2'b01; //transition to process state if counter reaches threshold
        end
        2'b10: begin //process state
          out <= in;
          state <= 2'b11; //transition to done state
        end
        2'b11: begin //done state
          out <= in;
          state <= 2'b00; //transition back to idle state
        end
      endcase
    end
  end

endmodule
