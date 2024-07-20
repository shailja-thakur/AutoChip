module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);
    // Declare intermediate wires
    wire and1, nand1, and2, not1, not2, or1, and3, or2, or3;
    
    // Logic for out_sop output
    assign out_sop = (c & d) | ((!a & !b & c));
    
    // Logic for out_pos output
    assign and1 = c & (!b | d);
    assign and2 = (!a | b) | (!a & d);
    assign or1 = and1 | and2;
    
    assign and3 = c & (!a | d);
    assign or2 = and3;
    
    assign or3 = or1 | or2;

    // Implement the ternary expression and assign out_pos
    always @(*) begin
        case ({or1, or2})
            2'b00: out_pos = 1'bx;
            default: out_pos = or3;
        endcase
    end

endmodule
