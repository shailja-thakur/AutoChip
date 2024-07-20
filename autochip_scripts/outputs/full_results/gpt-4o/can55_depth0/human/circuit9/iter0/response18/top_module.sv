module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

    always @(posedge clk) begin
        if (a) 
            q <= 3'b100;  // Sets q to 4 when a is 1
        else 
            q <= q + 1;  // Increments q when a is 0
    end

endmodule
