module top_module(
  input clk,
  input reset,
  output shift_ena,
  output reg[2:0] state);
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b00;  // reset state to B0
      shift_ena <= 1'b1;  // enable shift
    end
    else begin
      case (state)
        3'b00: begin  // B0
          state <= 3'b01;  // transition to B1
          shift_ena <= 1'b1;  // enable shift
        end
        3'b01: begin  // B1
          state <= 3'b10;  // transition to B2
          shift_ena <= 1'b1;  // enable shift
        end
        3'b10: begin  // B2
          state <= 3'b11;  // transition to B3
          shift_ena <= 1'b1;  // enable shift
        end
        3'b11: begin  // B3
          state <= 3'b00;  // transition to Done
          shift_ena <= 1'b1;  // enable shift
        end
        default: begin  // Done
          state <= 3'b11;  // stay in Done
          shift_ena <= 1'b0;  // disable shift
        end
      endcase
    end
  end

endmodule
