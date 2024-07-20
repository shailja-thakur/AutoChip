module top_module (
    input a, 
    input b,
    input c,
    input d,
    output reg out
);

always @(*)
begin
    case({c,d,a,b}) // Updated the order of inputs to match the Karnaugh map
        4'b00xx: out = 1'b1; // Updated the cases to match the Karnaugh map
        4'b01xx: out = 1'b0; // Updated the cases to match the Karnaugh map
        4'b10xx: out = 1'b1;
        4'b11xx: out = 1'b1;
        default: out = 1'bx;
    endcase
end

endmodule
