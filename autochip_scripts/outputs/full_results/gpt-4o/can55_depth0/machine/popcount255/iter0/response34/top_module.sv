module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    always_comb begin
        out = 0; // Initialize output to 0
        for (integer i = 0; i < 255; i = i + 1) begin
            out = out + in[i]; // Sum up all bits in the input signal
        end
    end

endmodule
