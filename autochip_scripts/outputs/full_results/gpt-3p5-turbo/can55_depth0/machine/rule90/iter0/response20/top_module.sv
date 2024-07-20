module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= {q[$bits(q)-2:0], q[$bits(q)-1]} ^ 1'b0;
        end
    end

endmodule
