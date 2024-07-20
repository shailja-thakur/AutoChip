module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // Define state encoding
    typedef enum reg [2:0] {
        S     = 3'd0,
        S1    = 3'd1,
        S11   = 3'd2,
        S110  = 3'd3,
        Done  = 3'd4
    } state_t;

    // Declare state register and next state variable
    reg [2:0] state, next_state;

    // Combinational logic for next state
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

    // Sequential logic to update state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end

    // Output logic based on current state
    always @(*) begin
        if (state == Done)
            start_shifting = 1'b1;
        else
            start_shifting = 1'b0;
    end
endmodule
