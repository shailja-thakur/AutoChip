module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state, next_state;

    // State encoding
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            S0: if (x) next_state = S1; else next_state = S0;
            S1: if (x) next_state = S4; else next_state = S1;
            S2: if (x) next_state = S1; else next_state = S2;
            S3: if (x) next_state = S2; else next_state = S1;
            S4: if (x) next_state = S4; else next_state = S3;
            default: next_state = S0;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) 
            state <= S0;
        else 
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            S0: z = 0;
            S1: z = 0;
            S2: z = 0;
            S3: z = 1;
            S4: z = 1;
            default: z = 0;
        endcase
    end

endmodule
