module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 3'b100;  // Equivalent to decimal 4
        end else begin
            if (q == 3'b110) 
                q <= 3'b000;  // Equivalent to decimal 0
            else 
                q <= q + 1;
        end
    end

endmodule
