module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

reg [1:0] state, next;

// State register
always @(posedge clk) begin
    if (!resetn)
        state <= 2'b00;
    else
        state <= next;
end

// Next state logic
always @(*) begin
    case (state)
        2'b00: // State A
            begin
                if (r[0])
                    next = 2'b01;
                else if (r[1])
                    next = 2'b10;
                else if (r[2])
                    next = 2'b11;
                else
                    next = 2'b00;
            end
        2'b01: // State B
            begin
                if (r[0])
                    next = 2'b01;
                else
                    next = 2'b00;
            end
        2'b10: // State C
            begin
                if (r[1])
                    next = 2'b10;
                else
                    next = 2'b00;
            end
        2'b11: // State D
            begin
                if (r[2])
                    next = 2'b11;
                else
                    next = 2'b00;
            end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        2'b01: // State B
            g = 3'b010;
        2'b10: // State C
            g = 3'b100;
        2'b11: // State D
            g = 3'b001;
        default:
            g = 3'b000;
    endcase
end

endmodule
