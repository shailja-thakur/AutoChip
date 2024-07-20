module top_module (
    input [6:1] y,
    input w,
    output wire Y2,
    output wire Y4
);

    wire [1:0] temp_y; // to store selected bits of y

    // Select bits 2, 3, 5, 6 of y
    assign temp_y = y[6:5];

    // Generate Y2 by taking the logical AND of the first bit of y and the logical NOT of w
    assign Y2 = y[1] & ~w;

    // Generate Y4 by taking the logical AND of selected bits of y and w
    assign Y4 = temp_y & w;

endmodule
