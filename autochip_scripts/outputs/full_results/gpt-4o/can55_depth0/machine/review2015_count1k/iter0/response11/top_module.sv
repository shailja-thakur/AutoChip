module top_module(
    input clk,
    input reset,
    output reg [9:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 10'b0; // Reset to 0 when reset signal is active
        end else if (q == 999) begin
            q <= 10'b0; // Reset to 0 when q reaches 999
        end else begin
            q <= q + 1; // Increment q by 1 otherwise
        end
    end
    
endmodule
