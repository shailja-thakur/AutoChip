module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) 
            q <= 4; // Reset q to 4 when a is 1
        else 
            q <= q + 1; // Increment q when a is 0
    end

endmodule
