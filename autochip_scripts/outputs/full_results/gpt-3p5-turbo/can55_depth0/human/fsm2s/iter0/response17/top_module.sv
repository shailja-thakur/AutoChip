module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);

  reg [1:0] state;
  reg [1:0] next_state;

  parameter OFF = 2'b00;
  parameter ON = 2'b01;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= OFF;
    end
    else begin
      state <= next_state;
    end
  end

  always @(*) begin
    case (state)
      OFF: begin
        if (j) begin
          next_state = ON;
        end
        else begin
          next_state = OFF;
        end
      end
      ON: begin
        if (k) begin
          next_state = OFF;
        end
        else begin
          next_state = ON;
        end
      end
      default: begin
        next_state = OFF;
      end
    endcase
  end

  always @(posedge clk) begin
    case (state)
      OFF: begin
        out <= 0;
      end
      ON: begin
        out <= 1;
      end
      default: begin
        out <= 0;
      end
    endcase
  end

endmodule
