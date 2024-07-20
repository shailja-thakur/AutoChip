module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // State encoding:
    // y = 000001 -> State A
    // y = 000010 -> State B
    // y = 000100 -> State C
    // y = 001000 -> State D
    // y = 010000 -> State E
    // y = 100000 -> State F
    
    // Output logic for Y2 (State B):
    // Y2 is high when:
    // A (--0--> B) when w = 0
    // Thus, Y2 = y[1] & ~w
    
    // Output logic for Y4 (State D):
    // Y4 is high when:
    // B (--1--> D) when w = 1
    // C (--1--> D) when w = 1
    // D (--1--> A) when w = 1
    // E --1--> D when w = 1
    // F --1--> D when w = 1
    // Thus, Y4 = (y[2] | y[3] | y[4] | y[5] | y[6]) & w
    
    assign Y2 = y[1] & ~w;
    assign Y4 = (y[2] | y[3] | y[4] | y[5] | y[6]) & w;
endmodule
