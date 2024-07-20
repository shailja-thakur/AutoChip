module top_module(
    input clk,
    input d,
    output reg q);
    
    wire q1, q2, clk_n;

    assign clk_n = ~clk;

    posedge_ff u1 (
        .clk(clk),
        .d(d),
        .q(q1)
    );

    negedge_ff u2 (
        .clk(clk_n),
        .d(d),
        .q(q2)
    );

    always @(*) begin
        if (clk) 
            q = q1;
        else
            q = q2;
    end

endmodule
module posedge_ff(
    input clk,
    input d,
    output reg q);

    always @(posedge clk) begin
        q <= d;
    end

endmodule
module negedge_ff(
    input clk,
    input d,
    output reg q);

    always @(negedge clk) begin
        q <= d;
    end

endmodule
