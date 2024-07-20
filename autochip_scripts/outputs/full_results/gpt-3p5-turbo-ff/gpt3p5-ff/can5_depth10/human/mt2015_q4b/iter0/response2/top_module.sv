module top_module(
    input x,
    input y,
    output z);
    
    // Define internal signals
    reg z_internal;
    
    always @(*) begin
        z_internal = x & y;
    end
    
    assign z = z_internal;
    
endmodule
