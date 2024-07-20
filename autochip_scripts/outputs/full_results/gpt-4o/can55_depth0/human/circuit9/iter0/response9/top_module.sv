module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    // Initialize q to an unknown state (default to 0)
    initial q = 3'b000;

    always @(posedge clk) begin
        if (a == 1)
            q <= 3'b100; // Set q to 4 when a is high
        else 
            q <= q + 1; // Increment q when a is low
    end
endmodule
