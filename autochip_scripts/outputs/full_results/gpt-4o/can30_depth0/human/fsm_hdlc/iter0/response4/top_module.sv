module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum reg [2:0] {
        S0 = 3'd0,
        S1 = 3'd1,
        S2 = 3'd2,
        S3 = 3'd3,
        S4 = 3'd4,
        S5 = 3'd5,
        S6 = 3'd6,
        S7 = 3'd7,
        S8 = 3'd8
    } state_t;

    state_t current_state, next_state;

    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        // Default outputs
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;
        
        case (current_state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: begin
                if (in) begin
                    next_state = S6;
                end else begin
                    disc = 1'b1;
                    next_state = S0;
                end
            end
            S6: begin
                if (in) begin
                    next_state = S7;
                end else begin
                    flag = 1'b1;
                    next_state = S0;
                end
            end
            S7: begin
                if (in) begin
                    err = 1'b1;
                    next_state = S8;
                end else begin
                    flag = 1'b1;
                    next_state = S0;
                end
            end
            S8: begin
                if (~in) next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

    // Output logic already embedded within state logic
endmodule
