module top_module(
  input clk,
  input reset,
  output shift_ena,
  output reg [2:0] state);
  
  always @(posedge clk) begin
    if (reset)
      state <= 3'b000;
    else begin
      case (state)
        3'b000: begin
          if (shift_ena)
            state <= 3'b001;
        end
        3'b001: begin
          if (shift_ena)
            state <= 3'b010;
        end
        3'b010: begin
          if (shift_ena)
            state <= 3'b011;
        end
        3'b011: begin
          if (shift_ena)
            state <= 3'b100;
        end
        default: state <= 3'b100;
      endcase
    end
  end
  
endmodule
