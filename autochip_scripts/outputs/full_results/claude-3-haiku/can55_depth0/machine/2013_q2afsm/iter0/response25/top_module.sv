module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state;
reg [1:0] next;

always @(posedge clk) begin
    if (!resetn)
        state <= 2'd0;
    else
        state <= next;
end

always @(*) begin
    case (state)
        2'd0: // State A
            if (r[0])
                next = 2'd1;
            else if (r[1])
                next = 2'd2;
            else if (r[2])
                next = 2'd3;
            else
                next = 2'd0;
        2'd1: // State B
            if (r[0])
                next = 2'd1;
            else
                next = 2'd0;
        2'd2: // State C
            if (r[1])
                next = 2'd2;
            else
                next = 2'd0;
        2'd3: // State D
            if (r[2])
                next = 2'd3;
            else
                next = 2'd0;
        default:
            next = 2'd0;
    endcase
end

always @(*) begin
    g = 3'b000;
    case (state)
        2'd1: g[0] = 1'b1;
        2'd2: g[1] = 1'b1;
        2'd3: g[2] = 1'b1;
        default: g = 3'b000;
    endcase
end

endmodule
