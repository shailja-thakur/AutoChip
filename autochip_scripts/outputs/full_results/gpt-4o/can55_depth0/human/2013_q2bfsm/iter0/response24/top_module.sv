module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] y_count;
    
    // State encoding
    localparam A = 3'b000,
               B = 3'b001,
               C = 3'b010,
               D = 3'b011,
               E = 3'b100,
               F = 3'b101;

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        f = 1'b0;
        case (state)
            A: begin
                f = 1'b1;
                next_state = B;
            end
            B: begin
                if (x)
                    next_state = C;
            end
            C: begin
                if (!x)
                    next_state = D;
            end
            D: begin
                if (x)
                    next_state = E;
            end
            E: begin
                g = 1'b1;
                y_count = 2;
                next_state = F;
            end
            F: begin
                g = 1'b1;
                if (y)
                    next_state = F;
                else if (y_count > 0)
                    y_count = y_count - 1;
                else
                    g = 1'b0;
            end
            default: next_state = A;
        endcase
    end
endmodule
