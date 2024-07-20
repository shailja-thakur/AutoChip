module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    
    // State transition logic
    // y[6:1] states: A=000001, B=000010, C=000100, D=001000, E=010000, F=100000
    // Y2 corresponds to state B (000010)
    // Y4 corresponds to state D (001000)
    
    // Deriving logic for Y2 (next state B)
    // B is reached from:
    // State A (y[1]) with w=0
    
    assign Y2 = (y[1] & ~w);

    // Deriving logic for Y4 (next state D)
    // D is reached from:
    // State B (y[2]) with w=1
    // State C (y[3]) with w=1
    // State D (y[4]) with w=1
    // State E (y[5]) with w=1
    // State F (y[6]) with w=1
    assign Y4 = (y[2] & w) | (y[3] & w) | (y[4] & w) | (y[5] & w) | (y[6] & w);

endmodule
