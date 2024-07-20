module top_module(
    input clk,
    input d,
    output reg q
);
    initial begin
        q = 1'bx; // set q to an unknown value initially
    end

    always @(posedge clk) begin
        q <= d; // update q with the value of d on the rising edge of clk
    end
endmodule
