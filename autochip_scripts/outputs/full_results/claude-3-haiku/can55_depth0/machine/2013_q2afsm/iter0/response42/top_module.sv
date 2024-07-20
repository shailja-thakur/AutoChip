module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;

// State register update
always @(posedge clk) begin
    if (!resetn)
        state <= 2'b00; // State A
    else
        state <= next;
end

// Next state logic
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
                next = 2'b00; // State A
        2'b01: // State B
            if (r[0])
                next = 2'b01; // State B
            else
                next = 2'b00; // State A
        2'b10: // State C
            if (r[1])
                next = 2'b10; // State C
            else
                next = 2'b00; // State A
        2'b11: // State D
            if (r[2])
                next = 2'b11; // State D
            else
                next = 2'b00; // State A
        default:
            next = 2'b00; // State A
    endcase
end

// Output logic
always @(*) begin
    g = 3'b000;
    case (state)
        2'b01: g[0] = 1'b1; // State B
        2'b10: g[1] = 1'b1; // State C
        2'b11: g[2] = 1'b1; // State D
        default: g = 3'b000;
    endcase
end

endmodule
