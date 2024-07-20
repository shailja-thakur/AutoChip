module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    reg [2:0] state, next_state;

    // State encoding
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;

    // State transition logic
    always @(*) begin
        case(state)
            S0: next_state = (x == 1'b0) ? S0 : S1;
            S1: next_state = (x == 1'b0) ? S1 : S4;
            S2: next_state = (x == 1'b0) ? S2 : S1;
            S3: next_state = (x == 1'b0) ? S1 : S2;
            S4: next_state = (x == 1'b0) ? S3 : S4;
            default: next_state = S0; // default state
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case(state)
            S3, S4: z = 1;
            default: z = 0;
        endcase
    end

endmodule
