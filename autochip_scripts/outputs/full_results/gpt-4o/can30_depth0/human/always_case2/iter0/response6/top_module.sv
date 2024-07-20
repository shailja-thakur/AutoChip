module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

    always @(in) begin
        casex (in)
            4'b1xxx: pos = 2'd3;
            4'b01xx: pos = 2'd2;
            4'b001x: pos = 2'd1;
            4'b0001: pos = 2'd0;
            default: pos = 2'd0;
        endcase
    end

endmodule
