module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  reg [3:1] state;  // Register to store the current state
  reg [3:1] next;   // Register to store the next state

  always @(posedge clk) begin
    if (!resetn) begin
      state <= 3'b001;  // Set state to A when resetn is low
    end else begin
      state <= next;    // Update state with the value of next
    end
  end

  always @(state or r) begin
    case(state)
      3'b001: begin     // State A
        if (r[1]) begin
          next <= 3'b010;  // Set next to B when r[1] is high
        end else if (r[2]) begin
          next <= 3'b011;  // Set next to C when r[2] is high
        end else if (r[3]) begin
          next <= 3'b100;  // Set next to D when r[3] is high
        end else begin
          next <= 3'b001;  // Set next to A when none of the bits of r are high
        end
      end
      3'b010: begin     // State B
        if (r[1]) begin
          next <= 3'b010;  // Stay in B when r[1] is high
        end else begin
          next <= 3'b001;  // Set next to A when r[1] is low
        end
      end
      3'b011: begin     // State C
        if (r[2]) begin
          next <= 3'b011;  // Stay in C when r[2] is high
        end else begin
          next <= 3'b001;  // Set next to A when r[2] is low
        end
      end
      3'b100: begin     // State D
        if (r[3]) begin
          next <= 3'b100;  // Stay in D when r[3] is high
        end else begin
          next <= 3'b001;  // Set next to A when r[3] is low
        end
      end
    endcase
  end

  assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0;  // g[1] is high when the current state is B
  assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0;  // g[2] is high when the current state is C
  assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0;  // g[3] is high when the current state is D

endmodule
