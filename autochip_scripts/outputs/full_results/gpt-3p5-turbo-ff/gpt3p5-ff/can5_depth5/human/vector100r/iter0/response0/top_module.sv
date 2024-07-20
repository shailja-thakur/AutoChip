module top_module (
    input [99:0] in,
    output reg [99:0] out
);

    reg [99:0] reversed;

    always @* begin
        for (int i = 0; i < 100; i++) begin
            reversed[i] = in[99-i];
        end
    end

    assign out = reversed;

endmodule
