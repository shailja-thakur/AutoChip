module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // State encoding
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    // Next state logic for Y2 (state B)
    // Y2 is 1 when next state is B
    // B is reached from A on input w = 0
    assign Y2 = (~w & y[1]);

    // Next state logic for Y4 (state D)
    // Y4 is 1 when next state is D
    // D is reached from B on input w = 1
    // D is reached from C on input w = 1
    // D is reached from D on input w = 0
    // D is reached from E on input w = 1
    // D is reached from F on input w = 1
    assign Y4 = (w & (y[2] | y[3] | y[5] | y[6])) | (~w & y[4]);

endmodule
