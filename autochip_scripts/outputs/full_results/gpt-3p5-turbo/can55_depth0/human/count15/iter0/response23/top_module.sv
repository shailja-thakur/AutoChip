module top_module(
    input clk,
    input reset,
    output reg [3:0] q);

    // internal wire declaration
    wire clk_inter;
    reg [3:0] next_q;

    // clock divider
    always @(posedge clk) begin
        clk_inter <= ~reset;
    end

    // counter
    always @(posedge clk_inter) begin
        if (reset) begin
            next_q <= 4'b0000;
        end else begin
            next_q <= q + 1;
        end
    end

    // output assignment
    always @(posedge clk_inter) begin
        q <= next_q;
    end

endmodule
