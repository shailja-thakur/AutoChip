module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

    always @(*) begin
        casez (in)
            4'b1???: pos = 2'd3; // highest priority, first bit found in position 3
            4'b01??: pos = 2'd2; // next priority, first bit found in position 2
            4'b001?: pos = 2'd1; // next priority, first bit found in position 1
            4'b0001: pos = 2'd0; // lowest priority, first bit found in position 0
            default: pos = 2'd0; // no bits found, output zero
        endcase
    end

endmodule
