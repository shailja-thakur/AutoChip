module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01  // Complement state
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= S0;
        else 
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: begin
                if (areset) 
                    next_state = S0;
                else 
                    next_state = (x == 1'b1) ? S1 : S0;
            end

            S1: begin
                if (areset) 
                    next_state = S0;
                else 
                    next_state = S1;
            end

            default: next_state = S0;
        endcase
    end

    always @(posedge clk or posedge areset) begin
        if (areset) 
            z <= 1'b0;
        else if (state == S0) 
            z <= ~x;
        else // state == S1
            z <= x;
    end

endmodule
