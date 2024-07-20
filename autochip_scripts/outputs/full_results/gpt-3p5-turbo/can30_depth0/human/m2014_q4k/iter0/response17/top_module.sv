module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    // D flop definition
    reg [3:0] d;
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            d <= 4'b0;
        else
            d <= {d[2:0], in};
    end

    // Output assignment
    assign out = d[3];

endmodule
