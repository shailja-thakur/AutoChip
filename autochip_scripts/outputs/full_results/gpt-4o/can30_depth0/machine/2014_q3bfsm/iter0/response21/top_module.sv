module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101, // Adding fictitious states for 3-bit encoding
        G = 3'b110,
        H = 3'b111
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (x == 1'b0) ? A : B;
            B: next_state = (x == 1'b0) ? B : E;
            C: next_state = (x == 1'b0) ? C : B;
            D: next_state = (x == 1'b0) ? B : C;
            E: next_state = (x == 1'b0) ? D : E;
            default: next_state = A;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            z <= 1'b0;
        else
            z <= (state == D || state == E) ? 1'b1 : 1'b0;
    end
endmodule
