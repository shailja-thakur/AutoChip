module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [3:1] state;
reg [3:1] next;

always @(posedge clk) begin
    if (!resetn)
        state <= 3'b000; // state A
    else
        state <= next;
end

always @* begin
    case (state)
        3'b000: // state A
            if (r[1])
                next = 3'b001; // state B
            else if (r[2])
                next = 3'b010; // state C
            else if (r[3])
                next = 3'b011; // state D
            else
                next = 3'b000; // state A
        3'b001: // state B
            if (r[1])
                next = 3'b001; // state B
            else
                next = 3'b000; // state A
        3'b010: // state C
            if (r[2])
                next = 3'b010; // state C
            else
                next = 3'b000; // state A
        3'b011: // state D
            if (r[3])
                next = 3'b011; // state D
            else
                next = 3'b000; // state A
    endcase
end

assign g[1] = (state == 3'b001) ? 1'b1 : 1'b0; // state B
assign g[2] = (state == 3'b010) ? 1'b1 : 1'b0; // state C
assign g[3] = (state == 3'b011) ? 1'b1 : 1'b0; // state D

endmodule
