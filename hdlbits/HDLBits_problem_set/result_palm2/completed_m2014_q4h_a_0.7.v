module top_module (
    input in,
    output out);
    
    // Insert your code here
    
    always @(posedge clk) begin
        if (in) begin
            out <= 1;
        else begin
            out <= 0;
        end
    end
endmodule