module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    reg [2:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;  // Initial state is A
        else
            state <= next_state;
    end

    always @(state, w) begin
        case (state)
            3'b000:  // State A
                if (w)
                    next_state = 3'b001;  // Next state is B
                else
                    next_state = 3'b000;  // Next state is A
            3'b001:  // State B
                if (w)
                    next_state = 3'b010;  // Next state is C
                else
                    next_state = 3'b010;  // Next state is D
            3'b010:  // State C
                if (w)
                    next_state = 3'b100;  // Next state is E
                else
                    next_state = 3'b010;  // Next state is D
            3'b011:  // State D
                if (w)
                    next_state = 3'b011;  // Next state is F
                else
                    next_state = 3'b000;  // Next state is A
            3'b100:  // State E
                if (w)
                    next_state = 3'b100;  // Next state is E
                else
                    next_state = 3'b011;  // Next state is F
            3'b101:  // State F
                if (w)
                    next_state = 3'b010;  // Next state is C
                else
                    next_state = 3'b010;  // Next state is D
            default:
                next_state = 3'b000;  // Default state is A
        endcase
    end

    assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;
endmodule
