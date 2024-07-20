module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        q <= 4; // When 'a' is high, set q to 4
    end else begin
        if (q == 6)
            q <= 0;
        else 
            q <= q + 1;  // When 'a' is low, increment q, and reset to 0 after reaching 6
    end
end

endmodule
