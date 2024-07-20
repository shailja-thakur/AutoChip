module top_module (
    input [3:0] a, 
    input [3:0] b, 
    input [3:0] c, 
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

    always @* begin
        case ({a, b, c, d, e})
            5'b00_0_0 : q = b;    // 20ns
            5'b00_0_1 : q = e;    // 25ns
            5'b00_1_0 : q = a;    // 30ns
            5'b00_1_1 : q = d;    // 35ns
            5'b01_x_x : q = f;    // 40ns onwards
            5'b1_x_x_x : q = f;   // 40ns onwards
            default : q = 4'b0;   // before 20ns
        endcase
    end

endmodule
