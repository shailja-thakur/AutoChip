module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] d;
    wire [3:0] q;

    // Shift Register with D flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            d <= 4'b0000;
        end else begin
            d <= {d[2:0], in};
        end
    end

    // Output
    assign out = d[3];

endmodule
