module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] temp;
    reg signed [7:0] sum;

    // Add a and b
    always @*
    begin
        temp = a + b;
        sum = temp[7:0];
    end

    // Set output signals
    assign s = sum;
    assign overflow = (temp[8] == 1);

endmodule
