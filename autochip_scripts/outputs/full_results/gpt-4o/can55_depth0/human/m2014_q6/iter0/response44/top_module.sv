module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    // Define state encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;
    
    state_t current_state, next_state;

    // Sequential logic for state transitioning
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Combinational logic for next state and output
    always @(*) begin
        next_state = current_state;
        z = 1'b0; // default output value

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
endmodule
