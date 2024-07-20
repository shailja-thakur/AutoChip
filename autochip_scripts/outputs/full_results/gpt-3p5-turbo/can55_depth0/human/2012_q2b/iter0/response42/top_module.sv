module top_module (
  input [5:0] y,
  input w,
  output Y1,
  output Y3
);

reg [5:0] next_state;

always @* begin
  case(y)
    // A (0) --1--> B
    6'b000001: next_state = 6'b000010;
    // A (0) --0--> A
    6'b000001: next_state = 6'b000001;
    // B (0) --1--> C
    6'b000010: next_state = 6'b000100;
    // B (0) --0--> D
    6'b000010: next_state = 6'b001000;
    // C (0) --1--> E
    6'b000100: next_state = 6'b010000;
    // C (0) --0--> D
    6'b000100: next_state = 6'b001000;
    // D (0) --1--> F
    6'b001000: next_state = 6'b100000;
    // D (0) --0--> A
    6'b001000: next_state = 6'b000001;
    // E (1) --1--> E
    6'b010000: next_state = 6'b010000;
    // E (1) --0--> D
    6'b010000: next_state = 6'b001000;
    // F (1) --1--> C
    6'b100000: next_state = 6'b000100;
    // F (1) --0--> D
    6'b100000: next_state = 6'b001000;
    // Default state transition to A
    default: next_state = 6'b000001;
  endcase
end

reg [5:0] current_state;
always @(posedge w) begin
  current_state <= next_state;
end

assign Y1 = current_state[1];
assign Y3 = current_state[3];

endmodule
