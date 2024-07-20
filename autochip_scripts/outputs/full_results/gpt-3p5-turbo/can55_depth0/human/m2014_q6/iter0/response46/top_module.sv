module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define state enumeration
    typedef enum logic [2:0] {
        A,
        B,
        C,
        D,
        E,
        F
    } state_t;

    // Define current state and next state variables
    reg state_t current_state, next_state;

    // Default initial state
    initial begin
        current_state = A;
        z = 1'b0;
    end

    // Combinational logic to determine the next state and output value
    always_comb begin
        case (current_state)
            A: begin
                if (w)
                    next_state = A;
                else
                    next_state = B;
                z = 1'b0;
            end
            B: begin
                if (w)
                    next_state = D;
                else
                    next_state = C;
                z = 1'b0;
            end
            C: begin
                if (w)
                    next_state = D;
                else
                    next_state = E;
                z = 1'b0;
            end
            D: begin
                if (w)
                    next_state = A;
                else
                    next_state = F;
                z = 1'b0;
            end
            E: begin
                if (w)
                    next_state = D;
                else
                    next_state = E;
                z = 1'b1;
            end
            F: begin
                if (w)
                    next_state = D;
                else
                    next_state = C;
                z = 1'b1;
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

    // Edge sensitive flip-flop to update the current state on positive clock edge
    always @(posedge clk) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

endmodule
