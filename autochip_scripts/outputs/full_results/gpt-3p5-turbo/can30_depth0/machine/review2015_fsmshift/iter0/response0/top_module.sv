module top_module(
  input clk,
  input reset,
  output reg shift_ena
);
  reg [1:0] state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00; // B0
      shift_ena <= 1'b0;
    end else begin
      case (state)
        2'b00: begin // B0
          state <= 2'b01; // B1
          shift_ena <= 1'b1;
        end
        2'b01: begin // B1
          state <= 2'b10; // B2
          shift_ena <= 1'b1;
        end
        2'b10: begin // B2
          state <= 2'b11; // B3
          shift_ena <= 1'b1;
        end
        2'b11: begin // B3
          state <= 2'b10; // B2
          shift_ena <= 1'b1;
        end
        default: begin
          state <= 2'b11; // Done
          shift_ena <= 1'b0;
        end
      endcase
    end
  end
endmodule
