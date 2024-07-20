module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] state, next_state;

    // State Definitions
    localparam S_000 = 3'b000,
               S_001 = 3'b001,
               S_010 = 3'b010,
               S_011 = 3'b011,
               S_100 = 3'b100;

    // State Transition Logic
    always @(*) begin
        case (state)
            S_000: next_state = x ? S_001 : S_000;
            S_001: next_state = x ? S_100 : S_001;
            S_010: next_state = x ? S_001 : S_010;
            S_011: next_state = x ? S_010 : S_001;
            S_100: next_state = x ? S_100 : S_011;
            default: next_state = S_000;
        endcase
    end

    // Output Logic
    always @(*) begin
        case (state)
            S_000: z = 0;
            S_001: z = 0;
            S_010: z = 0;
            S_011: z = 1;
            S_100: z = 1;
            default: z = 0;
        endcase

        Y0 = next_state[0];
    end

    // State Update Logic
    always @(posedge clk) begin
        state <= next_state;
    end

endmodule
