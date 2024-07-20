module top_module (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output wire overflow
);

    reg [7:0] sum;

    // add the inputs a and b
    always @* begin
        sum = a + b;
    end

    // assign the 8 least significant bits of the sum to output s
    assign s = sum[7:0];

    // calculate the overflow bit
    assign overflow = (a[7] == b[7]) && (a[7] != sum[7]);

endmodule
