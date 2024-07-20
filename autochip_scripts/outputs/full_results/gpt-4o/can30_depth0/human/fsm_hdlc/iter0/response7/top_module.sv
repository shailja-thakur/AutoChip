module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum logic [2:0] {
        S0, // Initial state
        S1, // Seen 0
        S2, // Seen 01
        S3, // Seen 011
        S4, // Seen 0111
        S5, // Seen 01111
        S6, // Seen 011111
        S7  // Seen 0111111
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            disc <= 0;
            flag <= 0;
            err <= 0;
            case(state)
                S0: if (in) next_state <= S0; else next_state <= S1;
                S1: if (in) next_state <= S2; else next_state <= S1;
                S2: if (in) next_state <= S3; else next_state <= S1;
                S3: if (in) next_state <= S4; else next_state <= S1;
                S4: if (in) next_state <= S5; else next_state <= S1;
                S5: if (in) next_state <= S6; else next_state <= S1;
                S6: if (in) next_state <= S7; else begin
                        next_state <= S1; 
                        if (reset) begin
                            disc <= 1;
                        end
                     end
                S7: if (in) begin 
                        next_state <= S7;
                        if (reset) begin
                            err <= 1;
                        end
                    end else begin
                        disc <= 0;
                        flag <= 1;
                        err <= 0;
                        next_state <= S1;
                    end
            endcase
        end
    end 
endmodule
