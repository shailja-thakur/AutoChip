module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    // State encoding
    typedef enum reg [2:0] {
        S0, // Initial state (reset state, behaves as previous input was 0)
        S1, // Saw 0
        S2, // Saw 01
        S3, // Saw 011
        S4, // Saw 0111
        S5, // Saw 01111
        S6, // Saw 011111
        S7, // Saw 0111111
        ERROR // State when error is detected
    } state_t;

    state_t state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset) state <= S0;
        else state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0:     next_state = in ? S1 : S0;
            S1:     next_state = in ? S2 : S0;
            S2:     next_state = in ? S3 : S0;
            S3:     next_state = in ? S4 : S0;
            S4:     next_state = in ? S5 : S0;
            S5:     next_state = in ? S6 : S0;
            S6:     next_state = in ? S7 : S0;
            S7:     next_state = in ? ERROR : S0;
            ERROR:  next_state = ERROR;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end
        else begin
            disc <= 0;
            flag <= 0;
            err <= 0;
            case (state)
                S5: if (in == 0) disc <= 1; // Output needs to be asserted on next cycle
                S6: if (in == 0) flag <= 1; // Output needs to be asserted on next cycle
                S7: if (in == 1) err <= 1; // Output needs to be asserted on next cycle
                ERROR: err <= 1; // Output needs to be asserted on next cycle
                default: ;
            endcase
        end
    end

endmodule
