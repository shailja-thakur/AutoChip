module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;

    reg [2:0] state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A; // Initialize state to A on reset
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (x)
                    next_state = E;
                else
                    next_state = B;
            end
            C: begin
                if (x)
                    next_state = B;
                else
                    next_state = C;
            end
            D: begin
                if (x)
                    next_state = C;
                else
                    next_state = B;
            end
            E: begin
                if (x)
                    next_state = E;
                else
                    next_state = D;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            D: z = 1;
            E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
