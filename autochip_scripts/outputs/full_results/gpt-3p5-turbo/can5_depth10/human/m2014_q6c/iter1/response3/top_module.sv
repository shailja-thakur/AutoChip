module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Declare intermediate wires
    wire[6:1] y_next;

    // Next state logic
    assign y_next[1] = y[5];
    assign y_next[2] = !y[2] & !w;
    assign y_next[3] = y[6];
    assign y_next[4] = y[3] & !w;
    assign y_next[5] = y[4];
    assign y_next[6] = y[1];

    // Output logic
    assign Y2 = y_next[2];
    assign Y4 = y_next[4];
    
endmodule
