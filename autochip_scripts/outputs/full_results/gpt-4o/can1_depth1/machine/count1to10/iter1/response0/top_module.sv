module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Define the initial state of q
    initial begin
        q = 4'b0001;  // Set to 1
    end

    // Always block triggered on the rising edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;  // Reset q to 1
        end
        else begin
            if (q == 4'b1010) begin
                q <= 4'b0001;  // Reset q to 1 when q is 10
            end
            else begin
                q <= q + 1;  // Increment q by 1
            end
        end
    end

endmodule
