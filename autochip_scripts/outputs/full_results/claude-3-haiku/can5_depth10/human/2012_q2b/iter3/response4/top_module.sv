module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

always @(*) begin
    // Signal Y1 is the input to the state flip-flop y[1]
    // It is 1 when the current state is B (000010) and the input is 1,
    // or when the current state is D (001000) and the input is 0
    if ((y == 6'b000010 && w) || (y == 6'b001000 && !w))
        Y1 = 1;
    else
        Y1 = 0;

    // Signal Y3 is the input to the state flip-flop y[3]
    // It is 1 when the current state is C (000100) and the input is 0,
    // or when the current state is D (001000) and the input is 1,
    // or when the current state is F (100000) and the input is 1
    if ((y == 6'b000100 && !w) || (y == 6'b001000 && w) || (y == 6'b100000 && w))
        Y3 = 1;
    else
        Y3 = 0;
end

endmodule
