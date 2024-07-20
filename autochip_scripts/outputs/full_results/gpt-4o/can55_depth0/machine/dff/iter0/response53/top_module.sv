module top_module(
    input clk,
    input d,
    output reg q
);

    initial begin
        q = 1'bx; // Setting the initial value of q to unknown
    end

    always @(posedge clk) begin
        q <= d; // On rising edge of clock, assign d to q
    end

endmodule
