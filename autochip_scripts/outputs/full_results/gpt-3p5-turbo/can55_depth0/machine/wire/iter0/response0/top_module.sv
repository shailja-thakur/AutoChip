module top_module(
  input clk,
  input reset,
  output reg out,
  output reg valid
);

  reg [1:0] state;
  reg [7:0] counter;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      counter <= 0;
      out <= 0;
      valid <= 0;
    end
    else begin
      case(state)
        0: begin // idle state
          counter <= 0;
          out <= 0;
          valid <= 0;
          if (reset) begin
            state <= 0;
          end
          else if (clk) begin
            state <= 1;
          end
        end
        1: begin // wait state
          counter <= counter + 1;
          out <= 0;
          valid <= 0;
          if (counter == 10) begin // adjust the threshold as desired
            state <= 2;
          end
        end
        2: begin // process state
          out <= in; // replace 'in' with the data that needs to be processed
          valid <= 0;
          state <= 3;
        end
        3: begin // done state
          out <= in; // replace 'in' with the data that needs to be processed
          valid <= 1;
          state <= 0;
        end
        default: state <= 0;
      endcase
    end
  end

endmodule
