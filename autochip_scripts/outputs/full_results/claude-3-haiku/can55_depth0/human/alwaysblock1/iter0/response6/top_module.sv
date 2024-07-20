module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);

// Using an assign statement
assign out_assign = a & b;

// Using a combinational always block
always @(a or b) begin
    out_alwaysblock = a & b;
end

endmodule
