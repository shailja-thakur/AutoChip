module top_module (
    input [254:0] in,
    output reg [7:0] out
);

// Implement population count logic
always @(*) begin
    out = 0;
    for (int i = 0; i < 255; i++) begin
        if (in[i]) out++;
    end
end

endmodule
