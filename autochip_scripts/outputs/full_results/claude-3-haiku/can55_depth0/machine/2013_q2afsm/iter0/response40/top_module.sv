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
        state <= 2'd0; // State A
    else
        state <= next;
end

// Next state logic
always @(*) begin
    case (state)
        2'd0: // State A
            begin
                if (r[0])
                    next = 2'd1; // State B
                else if (r[1])
                    next = 2'd2; // State C
                else if (r[2])
                    next = 2'd3; // State D
                else
                    next = 2'd0; // State A
            end
        2'd1: // State B
            begin
                if (r[0])
                    next = 2'd1; // State B
                else
                    next = 2'd0; // State A
            end
        2'd2: // State C
            begin
                if (r[1])
                    next = 2'd2; // State C
                else
                    next = 2'd0; // State A
            end
        2'd3: // State D
            begin
                if (r[2])
                    next = 2'd3; // State D
                else
                    next = 2'd0; // State A
            end
        default:
            next = 2'd0; // State A
    endcase
end

// Output logic
always @(*) begin
    case (state)
        2'd1: g = 3'b010; // State B
        2'd2: g = 3'b100; // State C
        2'd3: g = 3'b001; // State D
        default: g = 3'b000; // State A
    endcase
end

endmodule
