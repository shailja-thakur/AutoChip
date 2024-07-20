module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [2:0] state, next_state;
    reg start_shifting_reg;
    
    // State encoding
    localparam S0 = 3'b000, // Initial state
               S1 = 3'b001, // State after receiving '1'
               S2 = 3'b010, // State after receiving '11'
               S3 = 3'b011, // State after receiving '110'
               S4 = 3'b100; // State after receiving '1101'
    
    // State transitions
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            S0: if (data) next_state = S1; else next_state = S0;
            S1: if (data) next_state = S2; else next_state = S0;
            S2: if (data) next_state = S2; else next_state = S3;
            S3: if (data) next_state = S4; else next_state = S0;
            S4: next_state = S4; // Remain in S4 once sequence is detected
            default: next_state = S0;
        endcase
    end
    
    // Output
    always @(posedge clk) begin
        if (reset)
            start_shifting_reg <= 0;
        else if (state == S4)
            start_shifting_reg <= 1;
    end
    
    assign start_shifting = start_shifting_reg;

endmodule
