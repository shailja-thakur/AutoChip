module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;

    // Register to hold the current state
    reg [2:0] state, next_state;

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (w == 1'b0)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (w == 1'b0)
                    next_state = C;
                else
                    next_state = D;
            end
            C: begin
                if (w == 1'b0)
                    next_state = E;
                else
                    next_state = D;
            end
            D: begin
                if (w == 1'b0)
                    next_state = F;
                else
                    next_state = A;
            end
            E: begin
                if (w == 1'b0)
                    next_state = E;
                else
                    next_state = D;
            end
            F: begin
                if (w == 1'b0)
                    next_state = C;
                else
                    next_state = D;
            end
            default:
                next_state = A;
        endcase
    end

    // State register update
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            E, F:
                z = 1'b1;
            default:
                z = 1'b0;
        endcase
    end

endmodule
