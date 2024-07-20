module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
  reg [1:0] state;
  reg [1:0] next_state;
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= 2'b00; // Set state to A
    end else begin
      state <= next_state; // Update state based on next_state
    end
  end
  
  always @(state, r) begin
    case (state)
      2'b00: // State A
        if (r[1]) begin
          next_state = 2'b01; // Next state B if r[1] is high
        end else if (r[2]) begin
          next_state = 2'b10; // Next state C if r[2] is high
        end else if (r[3]) begin
          next_state = 2'b11; // Next state D if r[3] is high
        end else begin
          next_state = 2'b00; // Next state A if none of the bits of r are high
        end
      2'b01: // State B
        if (r[1]) begin
          next_state = 2'b01; // Next state B if r[1] is high
        end else begin
          next_state = 2'b00; // Next state A if r[1] is low
        end
      2'b10: // State C
        if (r[2]) begin
          next_state = 2'b10; // Next state C if r[2] is high
        end else begin
          next_state = 2'b00; // Next state A if r[2] is low
        end
      2'b11: // State D
        if (r[3]) begin
          next_state = 2'b11; // Next state D if r[3] is high
        end else begin
          next_state = 2'b00; // Next state A if r[3] is low
        end
    endcase
  end
  
  always @(state) begin
    case (state)
      2'b01: // State B
        g[1] = 1'b1; // Set g[1] high
        g[2] = 1'b0; // Set g[2] low
        g[3] = 1'b0; // Set g[3] low
      2'b10: // State C
        g[1] = 1'b0; // Set g[1] low
        g[2] = 1'b1; // Set g[2] high
        g[3] = 1'b0; // Set g[3] low
      2'b11: // State D
        g[1] = 1'b0; // Set g[1] low
        g[2] = 1'b0; // Set g[2] low
        g[3] = 1'b1; // Set g[3] high
      default: // State A
        g[1] = 1'b0; // Set g[1] low
        g[2] = 1'b0; // Set g[2] low
        g[3] = 1'b0; // Set g[3] low
    endcase
  end
endmodule
