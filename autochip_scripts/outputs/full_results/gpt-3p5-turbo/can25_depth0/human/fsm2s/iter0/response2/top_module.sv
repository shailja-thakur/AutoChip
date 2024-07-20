module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  reg [1:0] state;
  reg out;

  parameter OFF = 2'b00;
  parameter ON = 2'b01;

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= OFF;
      out <= 0;
    end 
    else begin
      case (state)
        OFF: begin
          if (j)
            state <= ON;
          else
            state <= OFF;
          out <= 0;
        end
        ON: begin
          if (k)
            state <= OFF;
          else
            state <= ON;
          out <= 1;
        end
        default: begin
          state <= OFF;
          out <= 0;
        end
      endcase
    end
  end

endmodule
