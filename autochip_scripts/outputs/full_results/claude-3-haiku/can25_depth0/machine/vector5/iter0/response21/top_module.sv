module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

wire [24:0] temp1, temp2;

// Compute the first vector
assign temp1 = {5{~a}, 5{~b}, 5{~c}, 5{~d}, 5{~e}};

// Compute the second vector
assign temp2 = {5{a,b,c,d,e}};

// Compute the bitwise exclusive-or
assign out = temp1 ^ temp2;

endmodule
