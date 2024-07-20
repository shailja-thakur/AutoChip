module top_module (
    input [4:1] x,
    output reg f // Changed from logic to reg
);

// Define internal wires
wire w1, w2, w3, w4;

// Implement boolean expressions for each cell in the Karnaugh map
assign w1 = ~(x[3] | x[1]);
assign w2 = ~(x[3] & x[4]);
assign w3 = ~(x[3] & ~x[2]);
assign w4 = ~(~x[3] & x[1]);

// Implement boolean expression for the final output f
always @* begin
    f = ~(w1 & w2 & w3 & w4);
end

endmodule
