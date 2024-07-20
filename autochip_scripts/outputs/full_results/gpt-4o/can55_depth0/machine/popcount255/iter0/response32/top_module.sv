module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    always_comb begin
        out = 8'b0;  // Initialize output to 0
        for (int i = 0; i < 255; i = i + 1) begin
            out = out + in[i];  // Increment output by the value of each input bit
        end
    end

endmodule
