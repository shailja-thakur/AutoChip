module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

    reg [7:0] Q;

    // 8-bit Shift Register
    always @(posedge clk) begin
        if (enable)
            Q <= {Q[6:0], S}; // Shift left and insert S at Q[0]
    end

    // 3-bit Select Lines for Multiplexer
    wire [2:0] sel;
    assign sel = {A, B, C};

    // Multiplexer to select one of the Q outputs
    always @(*) begin
        case (sel)
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Should never happen
        endcase
    end

endmodule
