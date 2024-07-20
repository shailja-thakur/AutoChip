module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

    // 8-bit shift register
    reg [7:0] shift_reg;

    always @(posedge clk) begin
        if (enable) begin
            shift_reg <= {shift_reg[6:0], S};
        end
    end

    // 3-to-8 decoder for address
    wire [7:0] addr;
    assign addr[0] = ~A & ~B & ~C;
    assign addr[1] = ~A & ~B &  C;
    assign addr[2] = ~A &  B & ~C;
    assign addr[3] = ~A &  B &  C;
    assign addr[4] =  A & ~B & ~C;
    assign addr[5] =  A & ~B &  C;
    assign addr[6] =  A &  B & ~C;
    assign addr[7] =  A &  B &  C;

    // Output logic
    always @(*) begin
        Z = shift_reg[addr];
    end

endmodule
