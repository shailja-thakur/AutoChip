module top_module(
    input clk,
    input reset,
    output reg [9:0] q);
    
    // Initial block to ensure q starts at 0
    initial begin
        q = 10'b0;
    end

    // Always block triggered on the positive edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            q <= 10'b0; // Reset q to 0 when reset is active
        end else begin
            if (q == 10'd999) begin
                q <= 10'b0; // If q reaches 999, reset it to 0
            end else begin
                q <= q + 1; // Otherwise increment q by 1
            end
        end
    end
endmodule
