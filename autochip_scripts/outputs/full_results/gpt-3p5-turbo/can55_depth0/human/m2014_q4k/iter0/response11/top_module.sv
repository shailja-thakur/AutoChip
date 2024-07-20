module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    reg [3:0] d;
    wire [3:0] q;

    // Implement D flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            d <= 4'b0;
        end else begin
            d <= {in, d[3:1]};
        end
    end

    // Connect D flip-flops to output
    assign q = d;

    // Output
    assign out = q[0];
endmodule
