module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);

    // Initialize the counter to 0
    initial begin
        q = 4'b0000;
    end

    // Always block triggered on the rising edge of the clock or asynchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Asynchronous reset
            q <= 4'b0000;
        end else if (slowena) begin
            // Increment the counter if slowena is asserted
            if (q == 4'd9) begin
                // Reset the counter to 0 if it reaches 9
                q <= 4'b0000;
            end else begin
                // Increment the counter by 1
                q <= q + 4'b0001;
            end
        end
    end
endmodule
