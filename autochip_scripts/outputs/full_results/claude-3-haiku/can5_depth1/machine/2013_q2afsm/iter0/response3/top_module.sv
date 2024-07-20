module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;

always @(posedge clk) begin
    if (!resetn)
        state <= 2'd0;
    else
        state <= next;
end

always @(*) begin
    case (state)
        2'd0: // State A
            if (r[0]) next = 2'd1; // B
            else if (r[1]) next = 2'd2; // C
            else if (r[2]) next = 2'd3; // D
            else next = 2'd0; // A
        2'd1: // State B
            if (r[0]) next = 2'd1; // B
            else next = 2'd0; // A
        2'd2: // State C
            if (r[1]) next = 2'd2; // C
            else next = 2'd0; // A
        2'd3: // State D
            if (r[2]) next = 2'd3; // D
            else next = 2'd0; // A
        default:
            next = 2'd0;
    endcase
end

always @(*) begin
    g = 3'd0;
    case (state)
        2'd1: g[1] = 1'b1; // State B
        2'd2: g[2] = 1'b1; // State C
        2'd3: g[3] = 1'b1; // State D
    endcase
end

endmodule
