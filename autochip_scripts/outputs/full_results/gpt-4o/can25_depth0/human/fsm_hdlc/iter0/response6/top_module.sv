module top_module (
    input  clk,
    input  reset,
    input  in,
    output reg disc,
    output reg flag,
    output reg err
);
    typedef enum reg [2:0] {S0, S1, S2, S3, S4, S5, S6, ERROR} state_t;
    state_t current_state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = (in == 1'b0) ? S0 : S1;
            S1: next_state = (in == 1'b0) ? S0 : S2;
            S2: next_state = (in == 1'b0) ? S0 : S3;
            S3: next_state = (in == 1'b0) ? S0 : S4;
            S4: next_state = (in == 1'b0) ? S0 : S5;
            S5: next_state = (in == 1'b0) ? S0 : S6;
            S6: next_state = (in == 1'b0) ? S0 : ERROR;
            ERROR: next_state = (in == 1'b0) ? S0 : ERROR;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            // Default outputs
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;

            case (current_state)
                S5: if (in == 1'b0) disc <= 1'b1;
                S6: if (in == 1'b0) flag <= 1'b1;
                ERROR: err <= 1'b1;
            endcase
        end
    end
endmodule
