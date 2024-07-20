module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);
    
    // Declare state enumeration
    typedef enum logic [3:0] {
        A,   // State 0
        B,   // State 1
        S0,  // State 2
        S1,  // State 3
        S10, // State 4
        G1,  // State 5
        G2,  // State 6
        P0,  // State 7
        P1,  // State 8
    } state_t;
    
    // Declare register for current state
    reg [3:0] current_state;
    
    // Assign initial state
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            current_state <= A;
        end else if (current_state == B) begin
            current_state <= S0;
        end else if (current_state == S0) begin
            if (x) begin
                current_state <= S1;
            end else begin
                current_state <= S0;
            end
        end else if (current_state == S1) begin
            if (x) begin
                current_state <= S1;
            end else begin
                current_state <= S10;
            end
        end else if (current_state == S10) begin
            if (x) begin
                current_state <= G1;
            end else begin
                current_state <= S0;
            end
        end else if (current_state == G1) begin
            if (y) begin
                current_state <= P1;
            end else begin
                current_state <= G2;
            end
        end else if (current_state == G2) begin
            if (y) begin
                current_state <= P1;
            end else begin
                current_state <= P0;
            end
        end else if (current_state == P0) begin
            current_state <= P0;
        end else if (current_state == P1) begin
            current_state <= P1;
        end
    end
    
    // Output assignments based on current state
    always @(current_state) begin
        case (current_state)
            B: f = 1;
            G1, G2, P1: g = 1;
            default: f = 0; g = 0;
        endcase
    end
        
endmodule
