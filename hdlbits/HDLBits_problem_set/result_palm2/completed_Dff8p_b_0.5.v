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

    assign q[7] = d[7];
    assign q[6] = d[6];
    assign q[5] = d[5];
    assign q[4] = d[4];
    assign q[3] = d[3];
    assign q[2] = d[2];
    assign q[1] = d[1];
    assign q[0] = d[0];

endmodule