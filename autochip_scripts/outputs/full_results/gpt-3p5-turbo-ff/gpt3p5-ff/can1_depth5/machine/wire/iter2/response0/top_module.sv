module top_module(
  input wire clk,
  input wire rst,
  input wire in,
  output wire out);

  reg [1:0] state;
  reg [7:0] counter;
  reg [7:0] data;
  
  assign out = data;
  
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= 2'b00;
      counter <= 8'b0;
      data <= 8'b0;
    end else begin
      case(state)
        2'b00: begin // idle state
          counter <= 8'b0;
          data <= 8'b0;
          if (in) begin
            state <= 2'b01; // transition to wait state
          end
        end
        2'b01: begin // wait state
          if (counter == 8'd255) begin
            state <= 2'b10; // transition to process state
          end else begin
            counter <= counter + 1;
            data <= 8'b0;
          end
        end
        2'b10: begin // process state
          data <= in;
          state <= 2'b11; // transition to done state
        end
        2'b11: begin // done state
          if (!in) begin
            state <= 2'b00; // transition back to idle state
          end
        end
      endcase
    end
  end

endmodule
