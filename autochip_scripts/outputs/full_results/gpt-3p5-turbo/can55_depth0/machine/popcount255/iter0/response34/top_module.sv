module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    // Initialize output signal
    always_comb begin
        out = 0;
        
        // Iterate through input bits
        for (int i = 0; i < 255; i = i + 1) begin
            out = out + in[i];
        end
    end

endmodule
