module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset) 
            q <= 1;
        else begin
            q <= q ^ {(q[4] ^ q[2]), q[4:1]};
        end
    end

endmodule
