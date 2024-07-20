module top_module(
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

    // 8-bit shift register
    reg [7:0] Q;

    always @(posedge clk) begin
        if (enable) begin
            Q <= {Q[6:0], S};
        end
    end

    // 3-to-8 decoder
    wire [7:0] decoder_out;
    assign decoder_out = 1 << {A, B, C};

    // Multiplexer to select the output
    always @(*) begin
        Z = Q & decoder_out;
    end

endmodule
