module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    initial begin
        q = 3'bxxx; // Initial state
    end

    always @(posedge clk) begin
        if (a == 1) begin
            q <= 3'b100; // Set q to 4 when a is 1
        end else begin
            if (q == 3'b000)
                q <= 3'b000; // Reset q to 0 if it is 0
            else 
                q <= q + 1; // Increment q when a is 0 and q is not 0
        end
    end
endmodule
