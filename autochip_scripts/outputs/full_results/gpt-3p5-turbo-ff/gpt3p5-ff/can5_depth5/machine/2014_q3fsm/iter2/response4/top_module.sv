module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define the states
    typedef enum logic [3:0] {
        A,
        B,
        C,
        S10,
        S11,
        S20,
        S21,
        S22
    } state_type;
    
    // Define the current state and next state variables
    reg [3:0] current_state;
    reg [3:0] next_state;
    
    // Assign initial state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    // Assign next state based on the state machine logic
    always @(current_state, s, w) begin
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B;
                end
                else begin
                    next_state = A;
                end
            end
            B: begin
                if (w) begin
                    next_state = S11;
                end
                else begin
                    next_state = S10;
                end
            end
            C: begin
                if (w) begin
                    next_state = S11;
                end
                else begin
                    next_state = S10;
                end
            end
            S10: begin
                if (w) begin
                    next_state = S21;
                end
                else begin
                    next_state = S20;
                end
            end
            S11: begin
                if (w) begin
                    next_state = S22;
                end
                else begin
                    next_state = S21;
                end
            end
            S20: begin
                next_state = B;
            end
            S21: begin
                if (w) begin
                    next_state = C;
                end
                else begin
                    next_state = B;
                end
            end
            S22: begin
                if (w) begin
                    next_state = B;
                end
                else begin
                    next_state = C;
                end
            end
            default: next_state = A; // Added default case
        endcase
    end
    
    // Output logic
    always @(current_state) begin
        case (current_state)
            A: begin
                z = s;
            end
            S20: begin
                z = 1;
            end
            default: begin
                z = 0;
            end
        endcase
    end

endmodule
