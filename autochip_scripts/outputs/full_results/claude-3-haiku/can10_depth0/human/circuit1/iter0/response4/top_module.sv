module top_module (
    input a, 
    input b, 
    output q
);

wire and_out, nor_out;

assign and_out = a & b;
assign nor_out = ~(a | b);
assign q = (a & b) | (~(a | b));

endmodule
