module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State declaration
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    // State transition logic (combinational)
    always @(*) begin
        case (current_state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
        endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        out = (current_state == D);
    end
    
endmodule
