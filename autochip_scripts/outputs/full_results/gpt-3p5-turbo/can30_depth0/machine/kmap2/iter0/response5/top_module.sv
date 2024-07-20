module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

    reg temp1, temp2, temp3, temp4;
    
    always @(a or b or c or d) begin
        temp1 = ~(b|c);
        temp2 = ~(a|d);
        temp3 = a & c & d;
        temp4 = b & c & d;
        out = temp1 | temp2 | temp3 | temp4;
    end
    
endmodule
