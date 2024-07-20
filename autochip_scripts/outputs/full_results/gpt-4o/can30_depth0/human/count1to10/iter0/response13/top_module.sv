module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 4'b0001; // reset to 1
        end else begin
            if (q == 4'd10)
                q <= 4'b0001;  // roll over to 1 after reaching 10
            else
                q <= q + 1;    // increment counter
        end
    end
endmodule
