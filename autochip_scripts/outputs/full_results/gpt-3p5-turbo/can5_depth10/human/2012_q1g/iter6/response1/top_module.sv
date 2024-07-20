module top_module (
    input [4:1] x,
    output logic f
);

// Define internal wires
wire w1, w2, w3, w4;
reg f_reg;

// Implement boolean expressions for each cell in the Karnaugh map
assign w1 = ~(x[3] | x[1]);
assign w2 = ~(x[3] & x[4]);
assign w3 = ~(x[3] & ~x[2]);
assign w4 = ~(~x[3] & x[1]);

// Implement boolean expression for the final output f
// Use a register instead of assign statement to avoid mismatch errors
always @(posedge clk)
begin
    f_reg <= ~(w1 & w2 & w3 & w4);
end

// Assign the value of the register to the output
assign f = f_reg;

endmodule
