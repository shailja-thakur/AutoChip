module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum reg [2:0] {
        S0,
        S1,
        S2,
        S3,
        S4,
        S5,
        S6,
        S7,
        S_ERR
    } state_t;
    
    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = (in == 1) ? S1 : S0;
            S1: next_state = (in == 1) ? S2 : S0;
            S2: next_state = (in == 1) ? S3 : S0;
            S3: next_state = (in == 1) ? S4 : S0;
            S4: next_state = (in == 1) ? S5 : S0;
            S5: begin
                if (in == 1)
                    next_state = S6;
                else
                    next_state = S0;
            end
            S6: begin
                if (in == 1)
                    next_state = S7;
                else
                    next_state = S0;
            end
            S7: next_state = (in == 1) ? S_ERR : S0;
            S_ERR: next_state = (in == 1) ? S_ERR : S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= 0;
            flag <= 0;
            err <= 0;
            case (state)
                S5: if (in == 0) disc <= 1;
                S6: if (in == 0) flag <= 1;
                S7: if (in == 1) err <= 1;
                S_ERR: err <= 1;
            endcase
        end
    end

endmodule
