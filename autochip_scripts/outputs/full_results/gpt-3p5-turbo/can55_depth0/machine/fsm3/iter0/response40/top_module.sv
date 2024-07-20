module top_module(
    input clk,
    input in,
    input areset,
    output reg out
);

    // State declaration
    typedef enum logic [1:0] {
        A, B, C, D
    } state_e;
    
    // State and next state variables
    reg[state_e] state, next_state;
    
    // Combinational logic for next state
    always @(*) begin
        case(state)
            A: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
            C: begin
                if (in) begin
                    next_state = D;
                end else begin
                    next_state = A;
                end
            end
            D: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
            default: next_state = A;
        endcase
    end
    
    // Sequential logic for state transition
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(state) begin
        out = (state == D);
    end
    
endmodule
