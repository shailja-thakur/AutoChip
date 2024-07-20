module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [2:0] state, next_state;

    // State declaration
    localparam S0 = 3'b000, // Initial state
               S1 = 3'b001, // Detect first 1
               S2 = 3'b010, // Detect first 1, 1
               S3 = 3'b011, // Detect first 1, 1, 0
               S4 = 3'b100; // Detect sequence 1101

    // Sequential state transition
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = data ? S1 : S0;
            S1: next_state = data ? S2 : S0;
            S2: next_state = data ? S2 : S3;
            S3: next_state = data ? S4 : S0;
            S4: next_state = S4;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (state == S4)
            start_shifting <= 1;
    end

endmodule
