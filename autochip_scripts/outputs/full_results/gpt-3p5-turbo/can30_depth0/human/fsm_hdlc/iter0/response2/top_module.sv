module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state, next_state;
    reg disc_reg, flag_reg, err_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b001; // Initialize state
        end else begin
            state <= next_state; // Update state
        end
    end

    always @(state or in) begin
        disc_reg = 1'b0; // Initialize outputs
        flag_reg = 1'b0;
        err_reg = 1'b0;

        case (state)
            3'b000: begin // State 0
                if (in) begin
                    next_state = 3'b001; // Transition to State 1
                end else begin
                    next_state = 3'b000; // Remain in State 0
                end
            end

            3'b001: begin // State 1
                if (in) begin
                    next_state = 3'b010; // Transition to State 2
                end else begin
                    next_state = 3'b000; // Transition to State 0
                end
            end

            3'b010: begin // State 2
                if (in) begin
                    next_state = 3'b011; // Transition to State 3
                end else begin
                    next_state = 3'b000; // Transition to State 0
                end
            end

            3'b011: begin // State 3
                if (in) begin
                    next_state = 3'b100; // Transition to State 4
                end else begin
                    next_state = 3'b000; // Transition to State 0
                end
            end

            3'b100: begin // State 4
                if (in) begin
                    next_state = 3'b101; // Transition to State 5
                end else begin
                    next_state = 3'b000; // Transition to State 0
                end
            end

            3'b101: begin // State 5
                if (in) begin
                    next_state = 3'b110; // Transition to State 6
                end else begin
                    next_state = 3'b000; // Transition to State 0
                end
            end

            3'b110: begin // State 6
                if (in) begin
                    next_state = 3'b111; // Transition to State 7
                end else begin
                    next_state = 3'b000; // Transition to State 0
                end
            end

            3'b111: begin // State 7
                if (in) begin
                    next_state = 3'b111; // Remain in State 7
                end else begin
                    next_state = 3'b000; // Transition to State 0
                end
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0; // Reset outputs
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case (state)
                3'b000: begin
                    disc <= 1'b0; // Output values are determined by next_state transition
                    flag <= 1'b0;
                    err <= 1'b0;
                end

                3'b001: begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b0;
                end

                3'b010: begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b0;
                end

                3'b011: begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b0;
                end

                3'b100: begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b0;
                end

                3'b101: begin
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b0;
                end

                3'b110: begin
                    disc <= 1'b1; // Output values determined by FSM specification
                    flag <= 1'b0;
                    err <= 1'b0;
                end

                3'b111: begin
                    disc <= 1'b0;
                    flag <= 1'b1;
                    err <= 1'b1;
                end
            endcase
        end
    end

endmodule
