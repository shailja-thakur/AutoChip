module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 3'd4; // When a is 1, q is set to 4
        end
        else begin
            if (q == 3'd6)
                q <= 3'd0; // Reset q to 0 when q is 6
            else
                q <= q + 1; // Increment q by 1 when a is 0
        end
    end

endmodule
