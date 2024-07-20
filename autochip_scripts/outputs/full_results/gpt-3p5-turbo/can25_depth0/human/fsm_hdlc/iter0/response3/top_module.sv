module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    // Define states of the FSM
    typedef enum logic [2:0] {
        S0,     // State 0: Initial state
        S1,     // State 1: Detected 0
        S2,     // State 2: Detected 1
        S3,     // State 3: Detected 2
        S4,     // State 4: Detected 3
        S5,     // State 5: Detected 4
        S6,     // State 6: Detected 5
        S7,     // State 7: Detected 6
        S8      // State 8: Detected 7 or more
    } fsm_state;

    fsm_state current_state, next_state;

    // Initialize current state with S0
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Assign next state based on current state and input
    always_comb begin
        case (current_state)
            S0: begin
                if (in) begin
                    next_state = S2;
                end else begin
                    next_state = S1;
                end
            end
            S1: begin
                if (in) begin
                    next_state = S2;
                end else begin
                    next_state = S1;
                end
            end
            S2: begin
                if (in) begin
                    next_state = S3;
                end else begin
                    next_state = S1;
                end
            end
            S3: begin
                if (in) begin
                    next_state = S4;
                end else begin
                    next_state = S1;
                end
            end
            S4: begin
                if (in) begin
                    next_state = S5;
                end else begin
                    next_state = S1;
                end
            end
            S5: begin
                if (in) begin
                    next_state = S6;
                end else begin
                    next_state = S1;
                end
            end
            S6: begin
                if (in) begin
                    next_state = S7;
                end else begin
                    next_state = S1;
                end
            end
            S7: begin
                if (in) begin
                    next_state = S8;
                end else begin
                    next_state = S7;
                end
            end
            S8: begin
                if (in) begin
                    next_state = S8;
                end else begin
                    next_state = S1;
                end
            end
            default: next_state = S0;
        endcase
    end

    // Output assignments based on current state
    always @(posedge clk) begin
        case (current_state)
            S0: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
            S1: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
            S2: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
            S3: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
            S4: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
            S5: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
            S6: begin
                disc <= 1'b1;
                flag <= 1'b0;
                err <= 1'b0;
            end
            S7: begin
                disc <= 1'b0;
                flag <= 1'b1;
                err <= 1'b0;
            end
            S8: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b1;
            end
            default: begin
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
        endcase
    end

endmodule
