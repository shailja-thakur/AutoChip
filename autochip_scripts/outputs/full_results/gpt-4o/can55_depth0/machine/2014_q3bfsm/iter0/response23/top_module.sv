module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define state representation
    typedef enum logic [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (x) next_state = B;
                else next_state = A;
            end

            B: begin
                if (x) next_state = E;
                else next_state = B;
            end

            C: begin
                if (x) next_state = B;
                else next_state = C;
            end

            D: begin
                if (x) next_state = C;
                else next_state = B;
            end

            E: begin
                if (x) next_state = E;
                else next_state = D;
            end

            default: next_state = A; // Default case for safety
        endcase
    end

    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            D, E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
