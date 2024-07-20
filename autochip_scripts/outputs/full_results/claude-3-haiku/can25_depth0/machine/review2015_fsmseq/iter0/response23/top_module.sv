module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State definitions
    localparam S = 2'd0, S1 = 2'd1, S11 = 2'd2, S110 = 2'd3, DONE = 2'd4;

    // State register
    reg [1:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            S: begin
                if (data) next_state = S1;
                else next_state = S;
            end
            S1: begin
                if (data) next_state = S11;
                else next_state = S;
            end
            S11: begin
                if (data) next_state = S11;
                else next_state = S110;
            end
            S110: begin
                if (data) next_state = DONE;
                else next_state = S;
            end
            DONE: begin
                next_state = DONE;
            end
            default: next_state = S;
        endcase
    end

    // State update on clock
    always @(posedge clk or posedge reset) begin
        if (reset) state <= S;
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        start_shifting = (state == DONE);
    end

endmodule
