module top_module (
    input clk,
    input enable,
    input S,
    input [2:0] sel,
    output Z
);
    reg [7:0] q;

    always @(posedge clk) begin
        if (enable) begin
            q <= {q[6:0], S};
        end
    end

    assign Z = q[sel];
endmodule
