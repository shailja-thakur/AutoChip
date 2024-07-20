module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

// Use an assign statement to implement the AND gate
assign out_assign = a & b;

// Use a combinational always block to implement the AND gate
always @(*) begin
    out_alwaysblock = a & b;
end

endmodule
