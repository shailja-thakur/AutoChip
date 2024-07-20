module top_module (
    input wire clk,
    input wire d,
    input wire r,
    output wire q
);

    always @(posedge clk or posedge r) begin
        if (r)
            q <= 0;
        else
            q <= d;
    end
endmodule
