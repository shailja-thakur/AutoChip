module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
    reg [2:0] state, next_state; // 3-bit state register

    // State encoding
    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100;

    // State transition logic (next state)
    always @(*) begin
        case (state)
            S0: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (x)
                    next_state = S4;
                else
                    next_state = S1;
            end
            S2: begin
                if (x)
                    next_state = S1;
                else
                    next_state = S2;
            end
            S3: begin
                if (x)
                    next_state = S2;
                else
                    next_state = S1;
            end
            S4: begin
                if (x)
                    next_state = S4;
                else
                    next_state = S3;
            end
            default: 
                next_state = S0;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            S3: z = 1;
            S4: z = 1;
            default: z = 0;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

endmodule
