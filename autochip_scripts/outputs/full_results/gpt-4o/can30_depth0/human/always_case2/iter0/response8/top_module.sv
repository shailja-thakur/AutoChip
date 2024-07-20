module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

always @(*) begin
    casez (in) // casez allows ? to be a don't care condition, simplifies logic
        4'b1???: pos = 2'd3; // Highest priority
        4'b01??: pos = 2'd2;
        4'b001?: pos = 2'd1;
        4'b0001: pos = 2'd0; // Lowest priority
        default: pos = 2'd0; // For case when all inputs are zero
    endcase
end

endmodule
