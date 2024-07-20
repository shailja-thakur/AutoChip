module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state, next_state;

    // State encoding
    localparam S0 = 3'b000,
               S1 = 3'b001,
               S2 = 3'b010,
               S3 = 3'b011,
               S4 = 3'b100;

    // State transition
    always @(*) begin
        case (state)
            S0: 
                if (x == 1'b0)
                    next_state = S0;
                else
                    next_state = S1;
            S1: 
                if (x == 1'b0)
                    next_state = S1;
                else
                    next_state = S4;
            S2: 
                if (x == 1'b0)
                    next_state = S2;
                else
                    next_state = S1;
            S3: 
                if (x == 1'b0)
                    next_state = S1;
                else
                    next_state = S2;
            S4: 
                if (x == 1'b0)
                    next_state = S3;
                else
                    next_state = S4;
            default: 
                next_state = S0;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            S0: z = 1'b0;
            S1: z = 1'b0;
            S2: z = 1'b0;
            S3: z = 1'b1;
            S4: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
