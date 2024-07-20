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
        2'b00: begin // State A
            if (r[0])
                next = 2'b01; // State B
            else if (r[1])
                next = 2'b10; // State C
            else if (r[2])
                next = 2'b11; // State D
            else
                next = 2'b00; // Stay in State A
        end
        2'b01: begin // State B
            if (r[0])
                next = 2'b01; // Stay in State B
            else
                next = 2'b00; // Go to State A
        end
        2'b10: begin // State C
            if (r[1])
                next = 2'b10; // Stay in State C
            else
                next = 2'b00; // Go to State A
        end
        2'b11: begin // State D
            if (r[2])
                next = 2'b11; // Stay in State D
            else
                next = 2'b00; // Go to State A
        end
        default:
            next = 2'b00; // Go to State A
    endcase
end

always @(*) begin
    g = 3'b000;
    case (state)
        2'b01: g[1] = 1'b1; // Set g[1] in State B
        2'b10: g[2] = 1'b1; // Set g[2] in State C
        2'b11: g[3] = 1'b1; // Set g[3] in State D
        default: g = 3'b000; // Clear g in other states
    endcase
end

endmodule
