module top_module (
    input clk,
    input a,
    output reg q
);
    
    /* Always block triggered by positive edge of clock */
    always @(posedge clk) begin
        q <= ~a;  // Set q to inverse of a
    end
    
endmodule
