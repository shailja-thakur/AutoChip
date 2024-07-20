module top_module (
    input [7:0] in,
    output [31:0] out
);

    assign out = { {24{in}}, in }; // replicate 'in' 24 times and concatenate with original 'in'

endmodule
