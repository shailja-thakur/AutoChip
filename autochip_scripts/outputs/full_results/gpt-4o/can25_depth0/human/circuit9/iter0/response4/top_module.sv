module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) begin
            q <= 4; // Set q to 4 when a is 1
        end else begin
            q <= q + 1; // Increment q when a is 0
            if (q == 6)
                q <= 0; // Reset q to 0 when q reaches 6
        end
    end

endmodule
