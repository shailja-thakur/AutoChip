module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

reg [5:0] next_y;

always @(*) begin
    case (y)
        6'b000001: next_y = 6'b010000; // A -> E
        6'b000010: next_y = 6'b001000; // B -> D
        6'b000100: next_y = 6'b010000; // C -> E
        6'b001000: next_y = 6'b100000; // D -> F
        6'b010000: next_y = 6'b100001; // E -> A
        6'b100000: next_y = 6'b001100; // F -> C
        default: next_y = 6'b000000; // default to A
    endcase
end

always @(posedge w) begin
    y <= next_y;
end

assign Y1 = y[1];
assign Y3 = y[3];

endmodule
