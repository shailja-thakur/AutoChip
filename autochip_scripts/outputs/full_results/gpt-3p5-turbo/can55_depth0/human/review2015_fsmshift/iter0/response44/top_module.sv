module top_module(
  input clk,
  input reset,
  output shift_ena);

  reg [2:0] state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      shift_ena <= 1'b1;
    end else begin
      case (state)
        3'b000: begin
          if (input_pattern_detected) begin
            state <= 3'b001;
            shift_ena <= 1'b1;
          end else begin
            state <= 3'b000;
            shift_ena <= 1'b0;
          end
        end
        3'b001: begin
          state <= 3'b010;
          shift_ena <= 1'b1;
        end
        3'b010: begin
          state <= 3'b011;
          shift_ena <= 1'b1;
        end
        3'b011: begin
          state <= 3'b100;
          shift_ena <= 1'b1;
        end
        3'b100: begin
          state <= 3'b101;
          shift_ena <= 1'b1;
        end
        3'b101: begin
          state <= 3'b110;
          shift_ena <= 1'b1;
        end
        3'b110: begin
          state <= 3'b111;
          shift_ena <= 1'b1;
        end
        3'b111: begin
          state <= 3'b000;
          shift_ena <= 1'b0;
        end
      endcase
    end
  end
endmodule
