module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);
    reg selected_bit;
    
    always @(*) begin
        if (sel >= 0 && sel <= 255) begin
            selected_bit = in[sel];
        end
        else begin
            selected_bit = 0;
        end
    end
    
    assign out = selected_bit;
    
endmodule
