module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define state encoding
    typedef enum reg [1:0] {
        S = 2'b00,
        S1 = 2'b01,
        S10 = 2'b10
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            current_state <= S;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            S: begin
                if (x == 0)
                    next_state = S;
                else
                    next_state = S1;
                z = 0;
            end
            S1: begin
                if (x == 0)
                    next_state = S10;
                else
                    next_state = S1;
                z = 0;
            end
            S10: begin
                if (x == 0)
                    next_state = S;
                else
                    next_state = S1;
                z = x;
            end
            default: begin
                next_state = S;
                z = 0;
            end
        endcase
    end
endmodule
