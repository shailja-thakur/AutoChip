module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    // Define wire variables for intermediate calculations
    wire y_first_bit;
    wire y_second_bit;
    wire y_third_bit;
    wire y_fifth_bit;
    wire y_sixth_bit;

    // Assign wire variables to respective bits of input y
    assign y_first_bit = y[1];
    assign y_second_bit = y[2];
    assign y_third_bit = y[3];
    assign y_fifth_bit = y[5];
    assign y_sixth_bit = y[6];

    // Generate Y2 by taking logical AND of the first bit of y
    // and the logical NOT of w
    assign Y2 = y_first_bit & ~w;

    // Generate Y4 by taking logical AND of the second, third,
    // fifth and sixth bits of y and w
    assign Y4 = y_second_bit & y_third_bit & y_fifth_bit & y_sixth_bit & w;

endmodule
