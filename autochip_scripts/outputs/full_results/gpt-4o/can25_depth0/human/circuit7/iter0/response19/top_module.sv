module top_module (
    input clk,
    input a,
    output reg q
);

    // Sequential logic block, triggered on the rising edge of the clock
    always @(posedge clk) begin
        if (a) 
            q <= 0;  // When 'a' is 1, set 'q' to 0
        else 
            q <= 1;  // When 'a' is 0, set 'q' to 1
    end

endmodule
