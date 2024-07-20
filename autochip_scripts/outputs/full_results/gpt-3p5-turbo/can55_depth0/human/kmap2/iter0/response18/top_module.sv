module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);
	
    reg out_reg;
    
    always @(*) begin
        case ({c, d})
            2'b00: out_reg = 1'b1;
            2'b01: out_reg = (a && !b) || (!a && b);
            2'b10: out_reg = a && b;
            2'b11: out_reg = 1'b0;
        endcase
    end
    
    assign out = out_reg;
    
endmodule
