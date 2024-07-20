module top_module(
  input clk,
  input reset,
  output reg shift_ena,
  output reg [2:0] state);

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      shift_ena <= 1;
    end
    else begin
      case (state)
        3'b000: begin // B0
          state <= 3'b001;
          shift_ena <= 1;
        end
        3'b001: begin // B1
          state <= 3'b010;
          shift_ena <= 1;
        end
        3'b010: begin // B2
          state <= 3'b011;
          shift_ena <= 1;
        end
        3'b011: begin // B3
          state <= 3'b100;
          shift_ena <= 1;
        end
        3'b100: begin // Done
          state <= 3'b100;
          shift_ena <= 0;
        end
        default: begin
          state <= 3'b100;
          shift_ena <= 0;
        end
      endcase
    end
  end
  
endmodule
