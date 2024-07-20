module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state, next_state;
    
    // Define states
    localparam  S0 = 3'b000,  // No 1s
                S1 = 3'b001,  // 1
                S2 = 3'b010,  // 11
                S3 = 3'b011,  // 111
                S4 = 3'b100,  // 1111
                S5 = 3'b101,  // 11111
                S6 = 3'b110,  // 111110
                S7 = 3'b111;  // 111111 (error state)
    
    // Synchronous process to handle state transitions and outputs
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            {disc, flag, err} <= 3'b000;
        end else begin
            state <= next_state;
        end
    end
    
    // Combinational logic to determine next state
    always @(*) begin
        // Default outputs
        next_state = state;
        {disc, flag, err} = 3'b000;
        case (state)
            S0: if (in) next_state = S1;
            S1: if (in) next_state = S2; else next_state = S0;
            S2: if (in) next_state = S3; else next_state = S0;
            S3: if (in) next_state = S4; else next_state = S0;
            S4: if (in) next_state = S5; else next_state = S0;
            S5: if (in) next_state = S6; else next_state = S0;
            S6: if (in) next_state = S7; else begin
                    next_state = S0;
                    disc = 1'b1;  // Signal to discard a bit
                end
            S7: if (in) begin
                    next_state = S7;
                    err = 1'b1;  // Signal error for 7 or more consecutive 1s
                end else begin
                    next_state = S0;
                    flag = 1'b1;  // Signal flag for 01111110 sequence
                end
        endcase
    end
    
endmodule
