module top_module(
    input clk,
    input d,
    output reg q
);

    initial begin
        q = 1'hx; // Initial unknown state
    end

    always @(posedge clk) begin
        q <= d; // Synchronize d with clk
    end

endmodule
