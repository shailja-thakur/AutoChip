module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define the states
    localparam S = 0, S1 = 1, S11 = 2, S110 = 3, Done = 4;

    // State register
    reg [2:0] state, next_state;

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
                if (data) next_state = Done;
                else next_state = S;
            end
            Done: begin
                next_state = Done;
            end
            default: next_state = S;
        endcase
    end

    // State update logic
    always @(posedge clk or posedge reset) begin
        if (reset) state <= S;
        else state <= next_state;
    end

    // Output logic
    always @(*) begin
        start_shifting = (state == Done);
    end

endmodule
