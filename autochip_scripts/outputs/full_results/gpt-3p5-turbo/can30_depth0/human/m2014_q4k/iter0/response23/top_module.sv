module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] d;
    wire [3:0] q;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            d <= 4'b0;
        end else begin
            d <= {d[2:0], in};
        end
    end

    assign q = d;

    assign out = q[3];

endmodule
