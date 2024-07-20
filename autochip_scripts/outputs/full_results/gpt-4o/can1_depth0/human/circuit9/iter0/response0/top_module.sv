module top_module (
    input clk,
    input a,
    output reg [2:0] q
);
    
    initial q = 3'b100; // Initialize q to 4 (binary 100)

    always @(posedge clk) begin
        if (a)
            q <= 3'd4;
        else begin
            if (q == 3'd6)
                q <= 3'd0;
            else
                q <= q + 1;
        end
    end
    
endmodule
