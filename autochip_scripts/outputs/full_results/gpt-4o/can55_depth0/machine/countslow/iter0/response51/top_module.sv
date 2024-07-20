module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    // Always block triggered on the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        // Asynchronous reset
        if (reset) begin
            q <= 4'b0000;
        end
        else if (slowena) begin
            // Increment counter if slowena is asserted
            if (q == 9) begin
                q <= 4'b0000;
            end
            else begin
                q <= q + 1;
            end
        end
    end

endmodule
