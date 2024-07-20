module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // Initialization of the counter value
    initial begin
        q = 4'b0001;
    end

    // Always block, triggered on the rising edge of the clock signal
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001;  // When reset signal is active, set q to 1
        end else begin
            if (q == 4'b1010) begin
                q <= 4'b0001;  // When q reaches 10, reset it to 1
            end else begin
                q <= q + 1;  // Increment the counter
            end
        end
    end
endmodule
