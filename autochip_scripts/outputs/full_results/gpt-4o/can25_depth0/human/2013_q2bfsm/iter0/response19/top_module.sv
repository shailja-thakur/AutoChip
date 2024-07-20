module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] y_check;
    reg [1:0] x_sequence;
    
    // State encoding
    localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

    // State transitions
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            A: if (resetn) next_state = B;
            B: next_state = C;
            C: if (x_sequence == 2'b101) next_state = D;
            D: next_state = E;
            E: if (y == 1) next_state = F;
               else if (y_check == 2'b01) next_state = A; // Wait 2 clock cycles for y to become 1
            F: next_state = F; // Stay in F until reset
        endcase
    end

    // Output logic and other state-dependent logic
    always @(posedge clk) begin
        if (!resetn) begin
            f <= 0;
            g <= 0;
            x_sequence <= 2'b00;
            y_check <= 2'b00;
        end else begin
            case (state)
                A: begin
                    f <= 0;
                    g <= 0;
                end
                B: f <= 1;
                C: begin
                    f <= 0;
                    x_sequence <= {x_sequence[0], x};
                end
                D: begin
                    g <= 1; // g is set to 1 in state D
                    y_check <= 2'b00;
                end
                E: begin
                    if (y == 0)
                        y_check <= y_check + 1;
                    g <= (y == 1) ? 1 : 0;
                end
                F: g <= 1;
            endcase
        end
    end

endmodule
