module top_module(
    input clk,
    input d,
    output reg q
);

    initial begin
        q = 1'hx; // Set initial value of q to unknown
    end

    always @(posedge clk) begin
        q <= d;  // Set q to the value of d at rising edge of clk
    end
endmodule
