module top_module(
  input clk,
  input reset,
  output shift_ena,
  output reg [2:0] state);

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000; // B0
      shift_ena <= 1'b1;
    end else begin
      case (state)
        3'b000: begin // B0
          state <= 3'b001; // B1
          shift_ena <= 1'b1;
        end
        3'b001: begin // B1
          state <= 3'b010; // B2
          shift_ena <= 1'b1;
        end
        3'b010: begin // B2
          state <= 3'b011; // B3
          shift_ena <= 1'b1;
        end
        3'b011: begin // B3
          state <= 3'b100; // Done
          shift_ena <= 1'b1;
        end
        default: begin
          state <= 3'b100; // Done
          shift_ena <= 1'b0;
        end
      endcase
    end
  end

endmodule
