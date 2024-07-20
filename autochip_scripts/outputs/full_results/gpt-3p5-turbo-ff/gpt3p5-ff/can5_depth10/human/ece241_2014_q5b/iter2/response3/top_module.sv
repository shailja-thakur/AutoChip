module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

  // States
  reg [1:0] state_reg;
  reg [1:0] state_next;
  parameter A = 2'b00;
  parameter B = 2'b01;
  
  // Outputs
  assign z = (state_reg == B) ? 1'b1 : 1'b0;
  
  // Next state logic
  always @(posedge clk or posedge areset) begin
      if (areset) begin
          state_reg <= A;
      end else begin
          state_reg <= state_next;
      end
  end
  
  always @(state_reg or x) begin
      case(state_reg)
          A: begin
              if (x) begin
                  state_next = B;
              end else begin
                  state_next = A;
              end
          end
          B: begin
              if (!x) begin
                  state_next = B;
              end else begin
                  state_next = B;
              end
          end
      endcase
  end

endmodule
