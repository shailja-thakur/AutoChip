module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;

always @(posedge clk) begin
    if (~resetn)
        state <= 2'b00; // state A
    else
        state <= next;
end

always @(*) begin
    case (state)
        2'b00: // state A
            if (r[0])
                next = 2'b01; // state B
            else if (r[1])
                next = 2'b10; // state C
            else if (r[2])
                next = 2'b11; // state D
            else
                next = 2'b00; // state A
        2'b01: // state B
            if (r[0])
                next = 2'b01; // state B
            else
                next = 2'b00; // state A
        2'b10: // state C
            if (r[1])
                next = 2'b10; // state C
            else
                next = 2'b00; // state A
        2'b11: // state D
            if (r[2])
                next = 2'b11; // state D
            else
                next = 2'b00; // state A
    endcase
end

always @(*) begin
    g = 3'b000;
    case (state)
        2'b01: g[1] = 1'b1; // state B
        2'b10: g[2] = 1'b1; // state C
        2'b11: g[3] = 1'b1; // state D
    endcase
end

endmodule
