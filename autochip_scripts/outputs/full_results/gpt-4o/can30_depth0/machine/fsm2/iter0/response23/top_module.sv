module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // Define state encoding
    typedef enum reg [1:0] {A=2'b00, B=2'b01} state_t;
    state_t state, next_state;

    // Combinational block to determine next state
    always @(*) begin
        case (state)
            A: if (j) next_state = B; else next_state = A;
            B: if (k) next_state = A; else next_state = B;
            default: next_state = A; // default state
        endcase
    end
    
    // Sequential block to update state
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A; // Reset state
        else 
            state <= next_state; // Update state
    end

    // Output logic
    always @(*) begin
        out = (state == B); // out is high if state is B, else low
    end
endmodule
