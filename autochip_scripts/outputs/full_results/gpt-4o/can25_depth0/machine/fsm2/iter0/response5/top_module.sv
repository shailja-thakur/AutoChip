module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t current_state, next_state;
    
    // Combinational logic to determine next state
    always @(*) begin
        case (current_state)
            A: next_state = (j) ? B : A;
            B: next_state = (k) ? A : B;
            default: next_state = A;
        endcase
    end
    
    // Sequential logic to update current state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Output to indicate current state
    assign out = (current_state == B);

endmodule
