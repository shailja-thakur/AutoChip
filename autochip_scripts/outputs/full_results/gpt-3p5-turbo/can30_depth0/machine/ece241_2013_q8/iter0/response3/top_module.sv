module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);
  
  // Define states
  typedef enum logic [1:0] {
    S,
    S1,
    S10
  } state_type;

  // Define state registers
  reg [1:0] state_reg, state_next;

  // Define next state logic
  always @ (posedge clk) begin
    if (!aresetn) begin
      state_reg <= S;
    end
    else begin
      state_reg <= state_next;
    end
  end

  // Define output logic
  always @ (*) begin
    case (state_reg)
      S: begin
        z = 0;
      end
      S1: begin
        z = 0;
      end
      S10: begin
        z = x;
      end
    endcase
  end

  // Define next state logic
  always @ (*) begin
    case ({x, state_reg})
      2'b00: begin
        state_next = S;
      end
      2'b01: begin
        state_next = S1;
      end
      2'b10: begin
        state_next = S10;
      end
      2'b11: begin
        state_next = S1;
      end
      default: begin
        state_next = S;
      end
    endcase
  end

endmodule
