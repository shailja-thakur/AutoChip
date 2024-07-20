module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] d;
    reg reset;

    always @(posedge clk or negedge resetn) begin
        if (~resetn)
            reset <= 1'b0;
        else
            reset <= 1'b1;
    end

    always @(posedge clk or negedge reset) begin
        if (~reset)
            d <= 4'b0000;
        else
            d <= {d[2:0], in};
    end

    assign out = d[3];

endmodule
