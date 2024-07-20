module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

// Create 8 D flip-flops
    reg [7:0] d_ff_0;
    reg [7:0] d_ff_1;
    reg [7:0] d_ff_2;
    reg [7:0] d_ff_3;
    reg [7:0] d_ff_4;
    reg [7:0] d_ff_5;
    reg [7:0] d_ff_6;
    reg [7:0] d_ff_7;
    
    always @(posedge clk) begin
        if (d[0])
            d_ff_0 <= d[0];
        if (d[1])
            d_ff_1 <= d[1];
        if (d[2])
            d_ff_2 <= d[2];
        if (d[3])
            d_ff_3 <= d[3];
        if (d[4])
            d_ff_4 <= d[4];
        if (d[5])
            d_ff_5 <= d[5];
        if (d[6])
            d_ff_6 <= d[6];
        if (d[7])
            d_ff_7 <= d[7];
    end
    
    assign q[0] = d_ff_0;
    assign q[1] = d_ff_1;
    assign q[2] = d_ff_2;
    assign q[3] = d_ff_3;
    assign q[4] = d_ff_4;
    assign q[5] = d_ff_5;
    assign q[6] = d_ff_6;
    assign q[7] = d_ff_7;

endmodule
