module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b010; // Initialize state to A
    end else begin
      case (state)
        3'b000: // A
          if (x) begin
            state <= 3'b001; // Transition to B
          end else begin
            state <= 3'b000; // Stay in A
          end
        3'b001: // B
          if (x) begin
            state <= 3'b100; // Transition to E
          end else begin
            state <= 3'b001; // Stay in B
          end
        3'b010: // C
          if (x) begin
            state <= 3'b001; // Transition to B
          end else begin
            state <= 3'b010; // Stay in C
          end
        3'b011: // D
          if (x) begin
            state <= 3'b010; // Transition to C
          end else begin
            state <= 3'b010; // Stay in D
          end
        3'b100: // E
          if (x) begin
            state <= 3'b100; // Stay in E
          end else begin
            state <= 3'b011; // Transition to D
          end
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (state == 3'b100 || state == 3'b101) begin // D or E
      z <= 1'b1; // Output high
    end else begin
      z <= 1'b0; // Output low
    end
  end

endmodule
