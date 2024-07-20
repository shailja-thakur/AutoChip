module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding
    wire A = y[1];
    wire B = y[2];
    wire C = y[3];
    wire D = y[4];
    wire E = y[5];
    wire F = y[6];

    // Derive the next state logic based on the state transitions given
    assign Y2 = (~w & A) | (~w & E);
    assign Y4 = (w & B) | (w & C) | (~w & D);

endmodule
