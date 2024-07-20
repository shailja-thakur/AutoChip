module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    
    reg q_reg;
    
    always @(a, b, c, d) begin
        case ({a, b, c, d})
            4'd0: q_reg = 1'b1;
            4'd1: q_reg = 1'b1;
            4'd2: q_reg = 1'b1;
            4'd3: q_reg = 1'b1;
            4'd4: q_reg = 1'b0;
            4'd5: q_reg = 1'b0;
            4'd6: q_reg = 1'b1;
            4'd7: q_reg = 1'b0;
            4'd8: q_reg = 1'b1;
            4'd9: q_reg = 1'b1;
            4'd10: q_reg = 1'b0;
            4'd11: q_reg = 1'b0;
            4'd12: q_reg = 1'b0;
            4'd13: q_reg = 1'b1;
            4'd14: q_reg = 1'b0;
            4'd15: q_reg = 1'b1;
            default: q_reg = 1'b1;
        endcase
    end
    
    assign q = q_reg;
  
endmodule
