module top_module (
    input clk,
    input reset,
    input x,
    output reg z
    );
    
    // State encoding
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;
    reg [2:0] state, next_state;
    
    // State transition on clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A; // Initialize state to A on reset
        end else begin
            state <= next_state; // Transition to the next state
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: if (x) next_state = B; else next_state = A;
            B: if (x) next_state = E; else next_state = B;
            C: if (x) next_state = B; else next_state = C;
            D: if (x) next_state = C; else next_state = B;
            E: if (x) next_state = E; else next_state = D;
            default: next_state = A; // Default to state A
        endcase
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0; // Initialize output to 0 on reset
        end else begin
            z <= (state == D) || (state == E); // Output is high when state is D or E
        end
    end
    
endmodule
