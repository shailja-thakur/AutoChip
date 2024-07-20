module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Always block triggered on rising edge of clock or positive edge of reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Set q to 1 when reset is active
            q <= 4'b0001;
        end else begin
            if (q == 4'b1010) begin
                // Reset q to 1 when it reaches 10
                q <= 4'b0001;
            end else begin
                // Increment q by 1
                q <= q + 1;
            end
        end
    end
endmodule
