module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire [3:0] c; // Carry Outputs
    wire [3:0] s; // Sum Outputs
    wire cout; // Overflow Bit

    assign cout = c[3]; // The overflow bit is the carry-out from the last adder stage

    // Full Adders
    full_adder fa0(x[0], y[0], 1'b0, c[0], s[0]);
    full_adder fa1(x[1], y[1], c[0], c[1], s[1]);
    full_adder fa2(x[2], y[2], c[1], c[2], s[2]);
    full_adder fa3(x[3], y[3], c[2], c[3], s[3]);

    assign sum = {cout, s[3:0]};

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output [1:0] cout,
    output s
);
    assign {cout[1], s} = a + b + cin;
endmodule
