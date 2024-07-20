module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;

always @(posedge clk) begin
    if (!resetn)
        state <= 2'b00; // State A
    else
        state <= next;
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (r[0])
                next = 2'b01; // State B
            else if (r[1])
                next = 2'b10; // State C
            else if (r[2])
                next = 2'b11; // State D
            else
                next = 2'b00; // Stay in State A
        2'b01: // State B
            if (r[0])
                next = 2'b01; // Stay in State B
            else
                next = 2'b00; // State A
        2'b10: // State C
            if (r[1])
                next = 2'b10; // Stay in State C
            else
                next = 2'b00; // State A
        2'b11: // State D
            if (r[2])
                next = 2'b11; // Stay in State D
            else
                next = 2'b00; // State A
        default:
            next = 2'b00; // State A
    endcase
end

always @(*) begin
    case (state)
        2'b01: g = 3'b010; // State B
        2'b10: g = 3'b100; // State C
        2'b11: g = 3'b001; // State D
        default: g = 3'b000; // State A
    endcase
end

endmodule
