module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state;
    reg [3:1] next_state;
    
    always @(posedge clk) begin
        if (!resetn)
            state <= 3'b001; // A
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            3'b001: // A
                if (r[1])
                    next_state = 3'b010; // B
                else if (r[2])
                    next_state = 3'b011; // C
                else if (r[3])
                    next_state = 3'b100; // D
                else
                    next_state = 3'b001; // A
            3'b010: // B
                if (r[1])
                    next_state = 3'b010; // B
                else
                    next_state = 3'b001; // A
            3'b011: // C
                if (r[2])
                    next_state = 3'b011; // C
                else
                    next_state = 3'b001; // A
            3'b100: // D
                if (r[3])
                    next_state = 3'b100; // D
                else
                    next_state = 3'b001; // A
            default:
                next_state = 3'b001; // A
        endcase
    end
    
    always @(*) begin
        g = 3'b000;
        case (state)
            3'b010: // B
                g[1] = 1'b1;
            3'b011: // C
                g[2] = 1'b1;
            3'b100: // D
                g[3] = 1'b1;
        endcase
    end
    
endmodule
