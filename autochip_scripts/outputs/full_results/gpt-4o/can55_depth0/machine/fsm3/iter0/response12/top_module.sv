module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define States
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    // State Register
    reg [1:0] state, next_state;

    // State Transition Logic (Combinational Logic)
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;
        endcase
    end

    // State Register Update Logic (Sequential Logic)
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Output Logic
    always @(state) begin
        out = (state == D);
    end

endmodule
