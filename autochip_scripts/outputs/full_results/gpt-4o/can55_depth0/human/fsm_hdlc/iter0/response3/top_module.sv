module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state, next_state;

    // State encoding
    localparam [2:0] S0 = 3'b000, // Initial state or after a '0'
                     S1 = 3'b001, // after a '01'
                     S2 = 3'b010, // after '011'
                     S3 = 3'b011, // after '0111'
                     S4 = 3'b100, // after '01111'
                     S5 = 3'b101, // after '011111'
                     S6 = 3'b110, // after '0111111'
                     S7 = 3'b111; // after '01111111' or error state

    // State transition logic (Moore FSM)
    always @(*) begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: next_state = in ? S7 : S0;
            S7: next_state = in ? S7 : S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        case (state)
            S5: if (!in) disc = 1'b1; // 011111 followed by 0
            S6: if (in) flag = 1'b1; // 0111111 followed by 1
            S7: err = 1'b1; // Error state (01111111... or more consecutive 1s)
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset) state <= S0;
        else state <= next_state;
    end

endmodule
