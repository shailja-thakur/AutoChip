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
            begin
                if (r[0])
                    next = 2'b01; // B
                else if (r[1])
                    next = 2'b10; // C
                else if (r[2])
                    next = 2'b11; // D
                else
                    next = 2'b00; // A
            end
        2'b01: // State B
            begin
                if (r[0])
                    next = 2'b01; // B
                else
                    next = 2'b00; // A
            end
        2'b10: // State C
            begin
                if (r[1])
                    next = 2'b10; // C
                else
                    next = 2'b00; // A
            end
        2'b11: // State D
            begin
                if (r[2])
                    next = 2'b11; // D
                else
                    next = 2'b00; // A
            end
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
