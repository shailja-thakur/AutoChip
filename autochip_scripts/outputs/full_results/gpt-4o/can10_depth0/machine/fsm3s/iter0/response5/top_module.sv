module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    // Declare state encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    // Present and next state variables
    state_t present_state, next_state;
    
    // Output logic
    assign out = (present_state == D);
    
    // State register: sequential logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            present_state <= A;
        end else begin
            present_state <= next_state;
        end
    end
    
    // Next state logic: combinational logic
    always_comb begin
        case (present_state)
            A: next_state = (in ? B : A);
            B: next_state = (in ? B : C);
            C: next_state = (in ? D : A);
            D: next_state = (in ? B : C);
            default: next_state = A; // Default case to avoid latches
        endcase
    end
endmodule
