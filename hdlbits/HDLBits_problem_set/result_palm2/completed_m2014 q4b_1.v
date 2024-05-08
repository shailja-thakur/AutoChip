module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);

    reg q;
    
    always @(posedge clk or posedge ar) begin
        if (ar) begin
            q <= d;
        end
    end

endmodule