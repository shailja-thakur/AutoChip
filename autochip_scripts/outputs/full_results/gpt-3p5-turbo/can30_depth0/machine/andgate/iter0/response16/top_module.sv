module top_module(
    input wire a, // added 'wire' keyword
    input wire b, // added 'wire' keyword
    output wire out // added 'wire' keyword
);
    assign out = a & b; // assigned output signal using logical AND operator
endmodule
