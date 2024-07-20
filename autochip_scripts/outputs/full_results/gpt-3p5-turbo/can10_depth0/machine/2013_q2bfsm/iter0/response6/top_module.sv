module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // Define the states
    typedef enum logic [3:0] {
        A,
        B,
        S0,
        S1,
        S10,
        G1,
        G2,
        P0,
        P1
    } state_t;

    // Define the current state and next state variables
    reg [3:0] current_state, next_state;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A; // Set initial state
        end else begin
            current_state <= next_state; // Update current state with next state
        end
    end
    
    always_comb begin
        // Default assignments for outputs
        f = 0;
        g = 0;
        
        case (current_state)
        
            A: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = S0;
                end
            end
            
            B: begin
                f = 1; // Assign f to 1 when in state B
                next_state = S0;
            end
            
            S0: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            
            S1: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S10;
                end
            end
            
            S10: begin
                if (x) begin
                    next_state = G1;
                end else begin
                    next_state = S0;
                end
            end
            
            G1: begin
                if (y) begin
                    next_state = P1;
                end else begin
                    next_state = G2;
                end
            end
            
            G2: begin
                if (y) begin
                    next_state = P1;
                end else begin
                    next_state = P0;
                end
            end
            
            P0: begin
                next_state = P0;
            end
            
            P1: begin
                next_state = P1;
            end
            
        endcase
        
    end

endmodule
