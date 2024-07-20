module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Implement the population count circuit
always @(*) begin
    out = 0;
    for (int i = 0; i < 255; i++) begin
        out += in[i];
    end
end

endmodule
