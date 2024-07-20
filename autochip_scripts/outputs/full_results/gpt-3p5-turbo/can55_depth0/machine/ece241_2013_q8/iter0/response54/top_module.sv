module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // State enumeration
    typedef enum logic [1:0] {
        S,
        S1,
        S10
    } state_type;

    // Declare state and next_state variables
    state_type state;
    state_type next_state;

    // Initialize state variable
    initial begin
        state = S;
    end

    // Always block for state and next_state transition
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end

    // Always block for next_state calculation based on input x and current state
    always @(state, x) begin
        case(state)
            S: begin
                if(x == 1'b1) begin
                    next_state = S1;
                end else begin
                    next_state = S;
                end
            end
            S1: begin
                if(x == 1'b1) begin
                    next_state = S1;
                end else begin
                    next_state = S10;
                end
            end
            S10: begin
                if(x == 1'b1) begin
                    next_state = S1;
                end else begin
                    next_state = S;
                end
            end
        endcase
    end

    // Always block for output z calculation based on current state
    always @(state) begin
        case(state)
            S, S1: begin
                z = 1'b0;
            end
            S10: begin
                z = x;
            end
        endcase
    end

endmodule
