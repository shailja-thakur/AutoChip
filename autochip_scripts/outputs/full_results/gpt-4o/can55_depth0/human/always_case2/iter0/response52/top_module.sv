module top_module (
    input [3:0] in,
    output reg [1:0] pos
);
    always @(*) begin
        casez (in)
            4'b1???: pos = 2'd3; // When the highest bit (bit[3]) is 1
            4'b01??: pos = 2'd2; // When bit[2] is 1
            4'b001?: pos = 2'd1; // When bit[1] is 1
            4'b0001: pos = 2'd0; // When bit[0] is 1
            default: pos = 2'd0; // Default case when none are 1
        endcase
    end
endmodule
