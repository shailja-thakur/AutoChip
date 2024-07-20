module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] count;

    // State encoding
    localparam A = 3'b000;
    localparam B = 3'b001;
    localparam C = 3'b010;
    localparam D = 3'b011;
    localparam E = 3'b100;
    localparam F = 3'b101;

    // State transition
    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                f = 0;
                g = 0;
                if (!resetn)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                f = 1;
                g = 0;
                next_state = C;
            end
            C: begin
                f = 0;
                g = 0;
                if (x == 1)
                    next_state = D;
                else
                    next_state = C;
            end
            D: begin
                if (x == 0)
                    next_state = E;
                else
                    next_state = D;
            end
            E: begin
                if (x == 1)
                    next_state = F;
                else
                    next_state = C;
            end
            F: begin
                f = 0;
                g = 1;
                if (y == 1)
                    next_state = F;
                else if (count == 2'b10)
                    next_state = C;
                else
                    next_state = F;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // Counter logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            count <= 0;
        else if (state == F && y == 0)
            count <= count + 1;
        else
            count <= 0;
    end

endmodule
