module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0001;  // Set q to 1 when reset is active
        end
        else begin
            if (q == 4'b1010) begin  // Check if q has reached 10
                q <= 4'b0001;  // Reset q to 1
            end
            else begin
                q <= q + 1;  // Increment q by 1 otherwise
            end
        end
    end
endmodule
