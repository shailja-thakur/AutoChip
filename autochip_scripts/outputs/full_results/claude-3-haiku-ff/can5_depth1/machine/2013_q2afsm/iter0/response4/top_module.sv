module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;

always @(posedge clk) begin
    if (~resetn)
        state <= 2'b00;
    else
        state <= next;
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (r[0]) next = 2'b01; // B
            else if (r[1]) next = 2'b10; // C
            else if (r[2]) next = 2'b11; // D
            else next = 2'b00; // A
        2'b01: // State B
            if (r[0]) next = 2'b01; // B
            else next = 2'b00; // A
        2'b10: // State C
            if (r[1]) next = 2'b10; // C
            else next = 2'b00; // A
        2'b11: // State D
            if (r[2]) next = 2'b11; // D
            else next = 2'b00; // A
        default: next = 2'b00; // A
    endcase
end

always @(*) begin
    g = 3'b000;
    case (state)
        2'b01: g[1] = 1'b1; // B
        2'b10: g[2] = 1'b1; // C
        2'b11: g[3] = 1'b1; // D
    endcase
end

endmodule
