module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

    typedef enum reg [2:0] {
        S0,  // Start state or previous input was 0
        S1,  // Saw 0, then 1
        S2,  // Saw 01
        S3,  // Saw 011
        S4,  // Saw 0111
        S5,  // Saw 01111
        S6,  // Saw 011111
        S7,  // Saw 0111111
        S8   // Saw 01111110
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Combinational logic for next state
    always @(*) begin
        next_state = state;
        case (state)
            S0: begin
                if (in) next_state = S1;
            end
            S1: begin
                if (in) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (in) next_state = S3;
                else next_state = S0;
            end
            S3: begin
                if (in) next_state = S4;
                else next_state = S0;
            end
            S4: begin
                if (in) next_state = S5;
                else next_state = S0;
            end
            S5: begin
                if (in) next_state = S6;
                else next_state = S0;
            end
            S6: begin
                if (in) next_state = S7;
                else next_state = S8;
            end
            S7: begin
                if (in) next_state = S7;  // Error condition
                else next_state = S0;
            end
            S8: begin
                next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

    // Combinational logic for outputs
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
                S6: if (!in) disc <= 1;
                S8: flag <= 1;
                S7: if (in) err <= 1;
                default: ;
            endcase
        end
    end

endmodule
