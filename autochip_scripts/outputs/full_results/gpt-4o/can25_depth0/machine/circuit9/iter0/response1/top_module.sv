module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    // Initialize the q output
    always @(posedge clk) begin
        if (a == 1) begin
            q <= 3'd4; // When a is 1, q is set to 4
        end else begin
            if (q == 3'd6) begin
                q <= 3'd0; // When a is 0 and q is 6, q is set to 0
            } else begin
                q <= q + 3'd1; // When a is 0 and q is not 6, q is increased by 1
            end
        end
    end
endmodule
