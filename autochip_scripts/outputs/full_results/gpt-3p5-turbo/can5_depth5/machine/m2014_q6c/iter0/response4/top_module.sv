module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire first_bit_y;
    wire not_w;
    wire second_bit_y;
    wire third_bit_y;
    wire fifth_bit_y;
    wire sixth_bit_y;
    
    assign first_bit_y = y[1];
    assign not_w = ~w;
    assign second_bit_y = y[2];
    assign third_bit_y = y[3];
    assign fifth_bit_y = y[5];
    assign sixth_bit_y = y[6];
    
    assign Y2 = first_bit_y & not_w;
    assign Y4 = second_bit_y & third_bit_y & fifth_bit_y & sixth_bit_y;

endmodule
