module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);

    reg [7:0] q[7:0];
    reg [7:0] d[7:0];

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            q <= 0x34;
        end else begin
            q <= d;
        end
    end

    assign q[7:0] = q[7:0];

endmodule