module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State assignments: 
    // y = 000001 => A
    // y = 000010 => B
    // y = 000100 => C
    // y = 001000 => D
    // y = 010000 => E
    // y = 100000 => F
    
    // Y1 (input for flip-flop y[1])
    // y[0] is A (000001)
    // y[3] is D (001000)
    // Therefore, Y1 = (y[0] & w) or (y[3] & w)
    assign Y1 = (y[0] & w) | (y[3] & w);
    
    // Y3 (input for flip-flop y[3])
    // y[1] is B (000010)
    // y[2] is C (000100)
    // y[4] is E (010000)
    // y[5] is F (100000)
    // Therefore, Y3 = (y[1] & !w) or (y[2] & !w) or (y[4] & !w) or (y[5] & !w)
    assign Y3 = (y[1] & !w) | (y[2] & !w) | (y[4] & !w) | (y[5] & !w);
    
endmodule
