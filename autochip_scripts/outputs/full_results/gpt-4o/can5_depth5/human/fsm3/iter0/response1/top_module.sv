module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states as local parameters
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
                out = 1'b0;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
                out = 1'b0;
            end
            C: begin
                if (in)
                    next_state = D;
                else
                    next_state = A;
                out = 1'b0;
            end
            D: begin
                if (in)
                    next_state = B;
                else
                    next_state = C;
                out = 1'b1;
            end
            default: begin
                next_state = A;
                out = 1'b0;
            end
        endcase
    end

    // State register logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
endmodule
