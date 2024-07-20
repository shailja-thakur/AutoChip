module top_module(
    input clk,
    input d,
    output reg q
);

    initial begin
        q = 1'hx; // Set initial value of q to 1'hx
    end

    always @(posedge clk) begin
        q <= d; // Assign value of d to q on rising edge of clk
    end

endmodule
