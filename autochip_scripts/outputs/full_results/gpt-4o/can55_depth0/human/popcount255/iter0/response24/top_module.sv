module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    integer i;

    always @(*) begin
        out = 0; // Ensure out is initialized to zero at the beginning
        for (i = 0; i < 255; i = i + 1) begin
            out = out + in[i];
        end
    end

endmodule
