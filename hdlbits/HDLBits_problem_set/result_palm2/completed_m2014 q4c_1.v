module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);

    reg q;

    always @(posedge clk or posedge r) begin
        if (r) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

endmodule