module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state, next_state;
    
    // Define states
    localparam  S0 = 3'b000,  // Initial state, no 1s
                S1 = 3'b001,  // 1
                S2 = 3'b010,  // 11
                S3 = 3'b011,  // 111
                S4 = 3'b100,  // 1111
                S5 = 3'b101,  // 11111
                S6 = 3'b110,  // 111110 or 0111110
                S7 = 3'b111;  // 111111 (error state)

    // Synchronous process to handle state transitions and outputs
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            {disc, flag, err} <= 3'b000;
        end else begin
            state <= next_state;
            {disc, flag, err} <= {1'b0, 1'b0, 1'b0};  // default outputs
            case (next_state)
                S6: disc <= 1'b1;  // Signal to discard a bit after 0111110
                S7: err <= 1'b1;   // Signal error for 7 or more consecutive 1s
                S0: if (state == S7 || state == S6) flag <= 1'b1; // Signal flag for 01111110
            endcase
        end
    end
    
    // Combinational logic to determine next state
    always @(*) begin
        // Default next state
        next_state = state;
        case (state)
            S0: if (in) next_state = S1;
            S1: if (in) next_state = S2; else next_state = S0;
            S2: if (in) next_state = S3; else next_state = S0;
            S3: if (in) next_state = S4; else next_state = S0;
            S4: if (in) next_state = S5; else next_state = S0;
            S5: if (in) next_state = S6; else next_state = S0;
            S6: if (in) next_state = S7; else next_state = S0;
            S7: if (in) next_state = S7; else next_state = S0;
        endcase
    end

endmodule
