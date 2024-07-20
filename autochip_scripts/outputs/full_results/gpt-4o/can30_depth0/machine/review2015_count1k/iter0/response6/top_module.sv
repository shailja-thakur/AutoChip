module top_module(
    input clk,
    input reset,
    output reg [9:0] q
);
    
    // Always block to trigger on positive edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            q <= 10'd0;
        end else begin
            if (q == 10'd999) begin
                q <= 10'd0;
            end else begin
                q <= q + 10'd1;
            end
        end
    end
    
endmodule
