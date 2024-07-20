module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
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

always @(posedge w) begin
    Y2 <= next_state[3]; // Corrected index from 2 to 3
    Y4 <= next_state[5]; // Corrected index from 4 to 5
end

endmodule
