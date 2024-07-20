module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define the states
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            2'b00: next_state = in ? B : A; // A: next_state = in ? B : A;
            2'b01: next_state = in ? B : C; // B: next_state = in ? B : C;
            2'b10: next_state = in ? D : A; // C: next_state = in ? D : A;
            2'b11: next_state = in ? B : C; // D: next_state = in ? B : C;
            default: next_state = A;
        endcase
    end
    
    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            2'b00: out = 1'b0; // A
            2'b01: out = 1'b0; // B
            2'b10: out = 1'b0; // C
            2'b11: out = 1'b1; // D
            default: out = 1'b0;
        endcase
    end

endmodule
