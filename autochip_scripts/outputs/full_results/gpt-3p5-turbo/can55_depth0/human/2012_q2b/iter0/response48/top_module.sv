module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg [5:0] next_state;

always @(*) begin
    case (y)
        6'b000001: next_state = 6'b000110; // A
        6'b000010: next_state = 6'b001001; // B
        6'b000100: next_state = 6'b010010; // C
        6'b001000: next_state = 6'b100100; // D
        6'b010000: next_state = 6'b001000; // E
        6'b100000: next_state = 6'b010001; // F
        default: next_state = 6'b000000;
    endcase
end

reg [5:0] current_state;
always @(posedge w) begin
    current_state <= next_state;
end

assign Y1 = current_state[1];
assign Y3 = current_state[3];

endmodule
