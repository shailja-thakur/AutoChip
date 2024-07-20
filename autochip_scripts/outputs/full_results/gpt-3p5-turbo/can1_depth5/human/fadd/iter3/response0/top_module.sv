module top_module (
    input a,
    input b,
    input cin,
    output reg cout,
    output reg sum
);

    wire w1, w2, w3;

    assign w1 = a ^ b;
    assign w2 = a & b;
    assign w3 = w1 & cin;

    always @*
    begin
        sum = w1 ^ cin;
        cout = w2 | w3;
    end

endmodule
