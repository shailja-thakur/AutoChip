module top_module (
  input clk,
  input resetn,
  input [2:0] r,
  output [2:0] g
);

  reg [1:0] state;
  reg [1:0] next_state;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= 2'b00;  // set initial state as A (00)
    else
      state <= next_state;  // update state based on next_state
  end

  always @(state or r) begin
    case (state)
      2'b00: begin  // State A
        if (r[2])
          next_state = 2'b10;  // Next state is C (10) if r[2] is high
        else if (r[1])
          next_state = 2'b01;  // Next state is B (01) if r[1] is high
        else if (r[0])
          next_state = 2'b11;  // Next state is D (11) if r[0] is high
        else
          next_state = 2'b00;  // Next state is A (00) if no bits of r are high
      end
      2'b01: begin  // State B
        if (r[1])
          next_state = 2'b01;  // Next state is B (01) if r[1] is high
        else
          next_state = 2'b00;  // Next state is A (00) if r[1] is low
      end
      2'b10: begin  // State C
        if (r[2])
          next_state = 2'b10;  // Next state is C (10) if r[2] is high
        else
          next_state = 2'b00;  // Next state is A (00) if r[2] is low
      end
      2'b11: begin  // State D
        if (r[0])
          next_state = 2'b11;  // Next state is D (11) if r[0] is high
        else
          next_state = 2'b00;  // Next state is A (00) if r[0] is low
      end
    endcase
  end

  always @(state) begin
    case (state)
      2'b00: g = 3'b000;  // All bits of g are low when state is A
      2'b01: g = 3'b001;  // g[0] is high when state is B
      2'b10: g = 3'b010;  // g[1] is high when state is C
      2'b11: g = 3'b100;  // g[2] is high when state is D
    endcase
  end

endmodule
