module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;

always @(posedge clk) begin
    if (!resetn)
        state <= 2'b00;
    else
        state <= next;
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (r[0])
                next = 2'b01;
            else if (r[1])
                next = 2'b10;
            else if (r[2])
                next = 2'b11;
            else
                next = 2'b00;
        2'b01: // State B
            if (r[0])
                next = 2'b01;
            else
                next = 2'b00;
        2'b10: // State C
            if (r[1])
                next = 2'b10;
            else
                next = 2'b00;
        2'b11: // State D
            if (r[2])
                next = 2'b11;
            else
                next = 2'b00;
    endcase
end

always @(*) begin
    g = 3'b000;
    case (state)
        2'b01: g[0] = 1'b1;
        2'b10: g[1] = 1'b1;
        2'b11: g[2] = 1'b1;
    endcase
end

endmodule
