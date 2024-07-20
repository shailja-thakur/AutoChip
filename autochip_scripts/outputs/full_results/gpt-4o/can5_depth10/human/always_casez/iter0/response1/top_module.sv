module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

    always @(*) begin
        case (1'b1)
            in[0]: pos = 3'd0;
            in[1]: pos = 3'd1;
            in[2]: pos = 3'd2;
            in[3]: pos = 3'd3;
            in[4]: pos = 3'd4;
            in[5]: pos = 3'd5;
            in[6]: pos = 3'd6;
            in[7]: pos = 3'd7;
            default: pos = 3'd0; // If no bits are high
        endcase
    end

endmodule
