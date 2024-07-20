module top_module (
    input [254:0] in,
    output reg [7:0] out
);

    always_comb begin
        out = 0; // Initialize the output signal to 0
        
        for (int i = 0; i < 255; i = i + 1) begin
            out = out + in[i]; // Add the value of each bit to the output signal
        end
    end

endmodule
