module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;

always @(posedge clk) begin
    if (!resetn) begin
        state <= 2'b00; // state A
    end
    else begin
        state <= next;
    end
end

always @(*) begin
    case (state)
        2'b00: // state A
            if (r[0]) begin
                next = 2'b01; // state B
            end
            else if (r[1]) begin
                next = 2'b10; // state C
            end
            else if (r[2]) begin
                next = 2'b11; // state D
            end
            else begin
                next = 2'b00; // stay in state A
            end
        2'b01: // state B
            if (r[0]) begin
                next = 2'b01; // stay in state B
            end
            else begin
                next = 2'b00; // go to state A
            end
        2'b10: // state C
            if (r[1]) begin
                next = 2'b10; // stay in state C
            end
            else begin
                next = 2'b00; // go to state A
            end
        2'b11: // state D
            if (r[2]) begin
                next = 2'b11; // stay in state D
            end
            else begin
                next = 2'b00; // go to state A
            end
    endcase
end

always @(*) begin
    g = 3'b000; // default
    case (state)
        2'b01: g[1] = 1'b1; // state B
        2'b10: g[2] = 1'b1; // state C
        2'b11: g[3] = 1'b1; // state D
    endcase
end

endmodule
