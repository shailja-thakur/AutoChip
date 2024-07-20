module top_module (
    input [254:0] in,
    output reg [7:0] out
);
    // always_comb block to describe combinatorial logic
    always_comb begin
        out = 8'b0; // initialize output to 0
        
        for (int i = 0; i < 255; i = i + 1) begin
            out = out + in[i]; // increment output by each bit of input
        end
    end
endmodule
