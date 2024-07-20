module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // States
    localparam S = 2'b00, S1 = 2'b01, S11 = 2'b10, S110 = 2'b11, Done = 3'b100;
    reg [2:0] state, next_state;

    // State update
    always @(posedge clk) begin
        if (reset)
            state <= S;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S: begin
                if (data)
                    next_state = S1;
                else
                    next_state = S;
            end
            S1: begin
                if (data)
                    next_state = S11;
                else
                    next_state = S;
            end
            S11: begin
                if (data)
                    next_state = S11;
                else
                    next_state = S110;
            end
            S110: begin
                if (data)
                    next_state = Done;
                else
                    next_state = S;
            end
            Done: begin
                next_state = Done;
            end
            default: begin
                next_state = S;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        start_shifting = (state == Done) ? 1'b1 : 1'b0;
    end

endmodule
