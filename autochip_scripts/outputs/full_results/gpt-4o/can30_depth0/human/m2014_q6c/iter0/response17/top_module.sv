module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Next state calculation for Y2 and Y4 using one-hot encoding

    // State encoding
    // A = 000001, y[6:1] = 000001
    // B = 000010, y[6:1] = 000010
    // C = 000100, y[6:1] = 000100
    // D = 001000, y[6:1] = 001000
    // E = 010000, y[6:1] = 010000
    // F = 100000, y[6:1] = 100000
    
    // Y2 corresponds to state "B"
    // Y2 = y[1] & ~w (A -> B on w=0)
    //     | y[2] & ~w (B -> C on w=0)
    //     | y[4] & (w) (D -> A on w=1)
    
    assign Y2 = (y[1] & ~w) |
                (y[2] & ~w) |
                (y[4] & w);
    
    // Y4 corresponds to state "D"
    // Y4 = y[2] & w (B -> D on w=1)
    //     | y[3] & w (C -> D on w=1)
    //     | y[5] & w (E -> D on w=1)
    //     | y[6] & w (F -> D on w=1)
    
    assign Y4 = (y[2] & w) |
                (y[3] & w) |
                (y[5] & w) |
                (y[6] & w);

endmodule
