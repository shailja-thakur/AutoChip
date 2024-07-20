module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);
    reg out;
    
    always @(*)
    begin
        case ({c,d})
            2'b00: out = 1'b1;
            2'b01: out = b;
            2'b10: out = a & b;
            2'b11: out = 1'b0;
        endcase
    end
    
endmodule
