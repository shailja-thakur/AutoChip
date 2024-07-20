module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Derive the Verilog by inspection assuming a one-hot encoding
assign Y1 = (y == 6'b000010 && w) || (y == 6'b001000 && !w);
assign Y3 = (y == 6'b000100 && !w) || (y == 6'b001000 && w) || (y == 6'b100000 && w);

endmodule
