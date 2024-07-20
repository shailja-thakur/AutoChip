module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Define state encoding
    reg [2:0] current_state, next_state;

    // State encoding
    localparam S0 = 3'b000,
               S1 = 3'b001,
               S2 = 3'b010,
               S3 = 3'b011,
               S4 = 3'b100;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case(current_state)
            S0: next_state = (x == 1'b0) ? S0 : S1;
            S1: next_state = (x == 1'b0) ? S1 : S4;
            S2: next_state = (x == 1'b0) ? S2 : S1;
            S3: next_state = (x == 1'b0) ? S1 : S2;
            S4: next_state = (x == 1'b0) ? S3 : S4;
            default: next_state = S0;
        endcase
    end

    // Output logic for z
    always @(*) begin
        case(current_state)
            S0: z = 1'b0;
            S1: z = 1'b0;
            S2: z = 1'b0;
            S3: z = 1'b1;
            S4: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
