module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

reg [6:1] next_state;

always @(*) begin
    case (y)
        7'b000001: next_state = 7'b000010;
        7'b000010: next_state = 7'b000100;
        7'b000100: next_state = 7'b001000;
        7'b001000: next_state = 7'b010000;
        7'b010000: next_state = 7'b100000;
        7'b100000: next_state = 7'b000001;
        default: next_state = 7'b000001;
    endcase
end

assign Y2 = next_state[2];
assign Y4 = next_state[4];

endmodule
