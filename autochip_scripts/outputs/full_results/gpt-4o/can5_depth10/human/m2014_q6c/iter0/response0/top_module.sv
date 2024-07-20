module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding:
    // y[6:1] = 000001 -> A
    // y[6:1] = 000010 -> B
    // y[6:1] = 000100 -> C
    // y[6:1] = 001000 -> D
    // y[6:1] = 010000 -> E
    // y[6:1] = 100000 -> F

    // Derive Y2 and Y4:

    // Y2 (State B):
    // y[6] -> F  --1--> D --> B
    // y[2] -> B  --0--> C --> B
    // y[4] -> D  --0--> F --> B 

    assign Y2 = (y[6] & w) | y[4] | (y[2] & ~w);

    // Y4 (State D):
    // y[1] -> A  --1--> A --> D
    // y[3] -> C  --1--> D --> D
    // y[5] -> E  --1--> D --> D
    // y[6] -> F  --1--> D --> D

    assign Y4 = (y[3] & w) | (y[5] & w) | (y[6] & w) | (y[1] & ~w);

endmodule
