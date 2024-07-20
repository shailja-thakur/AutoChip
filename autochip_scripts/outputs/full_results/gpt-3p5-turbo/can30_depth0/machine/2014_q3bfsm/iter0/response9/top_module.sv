module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b001;  // initialize state to A
    end else begin
      case (state)
        3'b000: begin  // state A
          if (x) begin
            state <= 3'b001;  // next state B
          end else begin
            state <= 3'b000;  // next state A
          end
        end
        3'b001: begin  // state B
          if (x) begin
            state <= 3'b100;  // next state E
          end else begin
            state <= 3'b001;  // next state B
          end
        end
        3'b010: begin  // state C
          if (x) begin
            state <= 3'b001;  // next state B
          end else begin
            state <= 3'b010;  // next state C
          end
        end
        3'b011: begin  // state D
          if (x) begin
            state <= 3'b010;  // next state C
          end else begin
            state <= 3'b001;  // next state B
          end
        end
        3'b100: begin  // state E
          if (x) begin
            state <= 3'b100;  // next state E
          end else begin
            state <= 3'b011;  // next state D
          end
        end
        default: begin
          state <= 3'b001;  // default state A
        end
      endcase
    end
  end

  always @(state) begin
    if (state == 3'b100 || state == 3'b101) begin
      z <= 1'b1;  // output is high when state is D or E
    end else begin
      z <= 1'b0;
    end
  end

endmodule
