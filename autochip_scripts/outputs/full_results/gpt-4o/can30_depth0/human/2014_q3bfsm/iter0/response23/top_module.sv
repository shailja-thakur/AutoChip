module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State declarations
    typedef enum reg [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: begin
                if (x) 
                    next_state = S1;
                else 
                    next_state = S0;
                z = 0;
            end
            S1: begin
                if (x) 
                    next_state = S4;
                else 
                    next_state = S1;
                z = 0;
            end
            S2: begin
                if (x) 
                    next_state = S1;
                else 
                    next_state = S2;
                z = 0;
            end
            S3: begin
                if (x)
                    next_state = S2;
                else 
                    next_state = S1;
                z = 1;
            end
            S4: begin
                if (x) 
                    next_state = S4;
                else 
                    next_state = S3;
                z = 1;
            end
            default: begin
                next_state = S0;
                z = 0;
            end
        endcase
    end

endmodule
