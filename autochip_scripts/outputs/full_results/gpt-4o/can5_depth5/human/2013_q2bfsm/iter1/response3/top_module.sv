module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] x_count, y_count;
    reg g_internal;

    // State encoding
    localparam [2:0] A = 3'b000,
                     B = 3'b001,
                     C = 3'b010,
                     D = 3'b011,
                     E = 3'b100;

    // State transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
            x_count <= 2'b00;
            y_count <= 2'b00;
        end
        else begin
            state <= next_state;
            if (state == C && x == 1'b1 && x_count == 2'b01) begin
                x_count <= x_count + 1;
            end
            else if (state == C && x == 1'b0 && x_count == 2'b10) begin
                x_count <= x_count + 1;
            end
            else if (state == C && x_count != 2'b01 && x_count != 2'b10) begin
                x_count <= x_count + 1;
            end
            
            if (state == D && y == 1'b0) begin
                y_count <= y_count + 1;
            end
            else if (state == D && y == 1'b1) begin
                y_count <= 2'b00;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                f = 1'b0;
                g_internal = 1'b0;
                if (!resetn) begin
                    next_state = A;
                end
                else begin
                    next_state = B;
                end
            end

            B: begin
                f = 1'b1;
                g_internal = 1'b0;
                next_state = C;
            end

            C: begin
                f = 1'b0;
                g_internal = 1'b0;
                if (x_count == 2'b11) begin
                    next_state = D;
                end
                else begin
                    next_state = C;
                end
            end

            D: begin
                f = 1'b0;
                g_internal = 1'b1;
                if (y == 1'b1) begin
                    next_state = E;
                end
                else if (y_count == 2'b10) begin
                    g_internal = 1'b0;
                    next_state = E;
                end
                else begin
                    next_state = D;
                end
            end

            E: begin
                f = 1'b0;
                if (g_internal == 1'b0) begin
                    g_internal = 1'b0;
                end
                else begin
                    g_internal = 1'b1;
                end
                next_state = E;
            end

            default: begin
                f = 1'b0;
                g_internal = 1'b0;
                next_state = A;
            end
        endcase
    end

    // Output assignments
    assign g = g_internal;

endmodule
