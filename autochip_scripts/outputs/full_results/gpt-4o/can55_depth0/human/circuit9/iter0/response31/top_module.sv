module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);
    always @(posedge clk) begin
        if (a) begin
            q <= 3'd4; // Set q to 4 when a is 1
        end else begin
            if (q == 3'd4) begin
                q <= 3'd5; // Set q to 5 when q is 4 and a becomes 0
            end else if (q == 3'd5) begin
                q <= 3'd6; // Set q to 6 when q is 5
            end else if (q == 3'd6) begin
                q <= 3'd0; // Set q to 0 when q is 6
            end else begin
                q <= q + 3'd1; // Increment q for other states
            end
        end
    end
endmodule
