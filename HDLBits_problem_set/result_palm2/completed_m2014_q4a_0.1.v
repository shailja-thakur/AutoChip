module top_module (
    input d, 
    input ena,
    output q);
    
    reg q;
    
    always @(posedge clk) begin
        if (ena) begin
            q <= d;
        end
    end

endmodule