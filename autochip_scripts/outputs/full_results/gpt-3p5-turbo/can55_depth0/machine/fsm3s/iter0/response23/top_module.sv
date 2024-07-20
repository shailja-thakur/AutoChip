module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  reg out;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00;  // initialize state to A
    end else begin
      case (state)
        2'b00: begin  // state A
          if (in) begin
            state <= 2'b01;  // change state to B
          else
            state <= 2'b00;  // state remains A
          end
        end
        2'b01: begin  // state B
          if (in) begin
            state <= 2'b01;  // state remains B
          else
            state <= 2'b10;  // change state to C
          end
        end
        2'b10: begin  // state C
          if (in) begin
            state <= 2'b11;  // change state to D
          else
            state <= 2'b00;  // change state to A
          end
        end
        2'b11: begin  // state D
          if (in) begin
            state <= 2'b01;  // change state to B
          else
            state <= 2'b10;  // change state to C
          end
        end
      endcase
    end
  end

  assign out = (state == 2'b11);  // set out to 1 when state is D

endmodule
