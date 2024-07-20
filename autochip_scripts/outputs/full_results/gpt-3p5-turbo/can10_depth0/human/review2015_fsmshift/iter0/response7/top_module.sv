module top_module(
  input clk,
  input reset,
  output reg shift_ena);

  reg [2:0] state;

  always @(posedge clk or posedge reset)
  begin
    if (reset)
      shift_ena <= 1'b0;
    else begin
      case (state)
        3'b000: begin
          if (pattern_detected)
            state <= 3'b001;
          else
            state <= 3'b000;
        end
        3'b001: begin
          state <= 3'b010;
        end
        3'b010: begin
          state <= 3'b011;
        end
        3'b011: begin
          shift_ena <= 1'b1;
          state <= 3'b100;
        end
        3'b100: begin
          shift_ena <= 1'b0;
          state <= 3'b101;
        end
        3'b101: begin
          state <= 3'b110;
        end
        3'b110: begin
          state <= 3'b111;
        end
        3'b111: begin
          state <= 3'b000;
        end
      endcase
    end
  end

  // Define pattern_detected logic here

endmodule
