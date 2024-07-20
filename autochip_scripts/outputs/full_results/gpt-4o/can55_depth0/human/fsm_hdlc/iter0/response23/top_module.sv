module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    // State encoding
    typedef enum reg [2:0] {
        S0, // Initial state (after a reset or zero input)
        S1, // Seen one 1
        S2, // Seen two 1s
        S3, // Seen three 1s
        S4, // Seen four 1s
        S5, // Seen five 1s
        S6, // Seen six 1s
        S7  // Error state: seen seven or more 1s
    } state_t;
    
    state_t state, next_state;

    // State registers
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (state)
            S0: begin
                next_state = in ? S1 : S0;
            end
            S1: begin
                next_state = in ? S2 : S0;
            end
            S2: begin
                next_state = in ? S3 : S0;
            end
            S3: begin
                next_state = in ? S4 : S0;
            end
            S4: begin
                next_state = in ? S5 : S0;
            end
            S5: begin
                next_state = in ? S6 : S0;
            end
            S6: begin
                next_state = in ? S7 : S0;
                if (!in)
                    disc = 1'b1;
                else
                    flag = 1'b1;
            end
            S7: begin
                next_state = in ? S7 : S0;
                err = 1'b1;
            end
        endcase
    end
endmodule
