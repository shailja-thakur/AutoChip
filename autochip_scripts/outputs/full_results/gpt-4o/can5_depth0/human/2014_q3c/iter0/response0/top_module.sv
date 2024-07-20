module top_module (
    input clk,
    input x,
    input [2:0] y,
    output reg Y0,
    output reg z
);

    reg [2:0] state, next_state;

    // Next state logic
    always @* begin
        case(state)
            3'b000: 
                if (x)
                    next_state = 3'b001;
                else
                    next_state = 3'b000;
            3'b001: 
                if (x)
                    next_state = 3'b100;
                else
                    next_state = 3'b001;
            3'b010: 
                if (x)
                    next_state = 3'b001;
                else
                    next_state = 3'b010;
            3'b011: 
                if (x)
                    next_state = 3'b010;
                else
                    next_state = 3'b001;
            3'b100: 
                if (x)
                    next_state = 3'b100;
                else
                    next_state = 3'b011;
            default: 
                next_state = 3'b000;
        endcase
    end

    // Output logic
    always @* begin
        case(state)
            3'b000: z = 0;
            3'b001: z = 0;
            3'b010: z = 0;
            3'b011: z = 1;
            3'b100: z = 1;
            default: z = 0;
        endcase

        Y0 = next_state[0];
    end

    // State registers
    always @(posedge clk) begin
        state <= next_state;
    end

endmodule
