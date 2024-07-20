module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // Define state encoding
    typedef enum reg [2:0] {
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5
    } state_t;

    // State registers
    state_t current_state, next_state;

    // Output logic based on current state
    assign z = (current_state == E) || (current_state == F);

    // State transition logic
    always @(*) begin
        case (current_state)
            A: next_state = (w == 1'b1) ? A : B;
            B: next_state = (w == 1'b1) ? D : C;
            C: next_state = (w == 1'b1) ? D : E;
            D: next_state = (w == 1'b1) ? A : F;
            E: next_state = (w == 1'b1) ? D : E;
            F: next_state = (w == 1'b1) ? D : C;
            default: next_state = A;
        endcase
    end

    // State register update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

endmodule
