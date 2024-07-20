module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);
    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00, 
        B = 2'b01, 
        C = 2'b10, 
        D = 2'b11
    } state_t;
    
    // State variables
    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: if (in) next_state = B;
               else next_state = A;
            B: if (in) next_state = B;
               else next_state = C;
            C: if (in) next_state = D;
               else next_state = A;
            D: if (in) next_state = B;
               else next_state = C;
            default: next_state = A;
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 0;
        else
            out <= (state == D);
    end
    
endmodule
