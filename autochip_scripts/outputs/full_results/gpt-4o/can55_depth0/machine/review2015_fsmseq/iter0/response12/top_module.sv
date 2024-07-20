module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    // State encoding
    typedef enum logic [2:0] {
        S     = 3'b000,
        S1    = 3'b001,
        S11   = 3'b010,
        S110  = 3'b011,
        Done  = 3'b100
    } state_t;

    state_t state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S: begin
                if (data) begin
                    next_state = S1;
                end else begin
                    next_state = S;
                end
            end
            S1: begin
                if (data) begin
                    next_state = S11;
                end else begin
                    next_state = S;
                end
            end
            S11: begin
                if (data) begin
                    next_state = S11;
                end else begin
                    next_state = S110;
                end
            end
            S110: begin
                if (data) begin
                    next_state = Done;
                end else begin
                    next_state = S;
                end
            end
            Done: begin
                next_state = Done;
            end
            default: begin
                next_state = S;
            end
        endcase
    end

    // State register (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        if (state == Done) begin
            start_shifting = 1;
        end else begin
            start_shifting = 0;
        end
    end

endmodule
