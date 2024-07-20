module top_module (
    input a,
    input b,
    input cin,
    output reg cout,
    output reg sum
);

    always @* begin
        sum = (a + b + cin) % 2;  // sum is the result of a + b + cin, modulo 2
        if (a + b + cin >= 2)    // if the sum of inputs is greater than or equal to 2
            cout = 1;            // set cout to 1
        else
            cout = 0;            // otherwise, set cout to 0
    end
    
endmodule
