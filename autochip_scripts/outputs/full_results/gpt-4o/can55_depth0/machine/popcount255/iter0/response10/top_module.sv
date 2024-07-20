module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    always @* begin
        integer i;
        out = 8'd0; // Initialize 'out' to 0
        for (i = 0; i < 255; i = i + 1) begin
            out = out + in[i];
        end
    end

endmodule
