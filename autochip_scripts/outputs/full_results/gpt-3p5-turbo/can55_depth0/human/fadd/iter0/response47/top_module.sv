module top_module (
    input a,
    input b,
    input cin,
    output reg cout,
    output reg sum
);

    always @(*) begin
        sum = a ^ b ^ cin;
        cout = (a & b) | (cin & (a ^ b));
    end

endmodule
