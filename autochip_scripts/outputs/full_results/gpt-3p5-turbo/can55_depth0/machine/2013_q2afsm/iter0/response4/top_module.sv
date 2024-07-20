module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        state <= 2'b00; // state A
    else
        state <= next_state;
end

always @* begin
    case (state)
        2'b00: // state A
            if (r[1])
                next_state = 2'b01; // state B
            else if (r[2])
                next_state = 2'b10; // state C
            else if (r[3])
                next_state = 2'b11; // state D
            else
                next_state = 2'b00; // state A
        2'b01: // state B
            if (r[1])
                next_state = 2'b01; // state B
            else
                next_state = 2'b00; // state A
        2'b10: // state C
            if (r[2])
                next_state = 2'b10; // state C
            else
                next_state = 2'b00; // state A
        2'b11: // state D
            if (r[3])
                next_state = 2'b11; // state D
            else
                next_state = 2'b00; // state A
        default:
            next_state = 2'b00; // state A
    endcase
end

always @(state) begin
    case (state)
        2'b01: // state B
            g[1] = 1'b1;
        2'b10: // state C
            g[2] = 1'b1;
        2'b11: // state D
            g[3] = 1'b1;
        default:
            g = 3'b0;
    endcase
end

endmodule
