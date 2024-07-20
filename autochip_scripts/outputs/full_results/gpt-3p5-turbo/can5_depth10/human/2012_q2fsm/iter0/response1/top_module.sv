module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state, next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    always @* begin
        case(state)
            3'b000: begin   // A
                if (w) 
                    next_state = 3'b001; // B (0)
                else
                    next_state = 3'b000; // A (0)
            end
            3'b001: begin   // B
                if (w)
                    next_state = 3'b010; // C (1)
                else
                    next_state = 3'b011; // D (0)
            end
            3'b010: begin   // C
                if (w)
                    next_state = 3'b100; // E (1)
                else
                    next_state = 3'b011; // D (0)
            end
            3'b011: begin   // D
                if (w)
                    next_state = 3'b101; // F (1)
                else
                    next_state = 3'b000; // A (0)
            end
            3'b100: begin   // E
                if (w)
                    next_state = 3'b100; // E (1)
                else
                    next_state = 3'b011; // D (0)
            end
            3'b101: begin   // F
                if (w)
                    next_state = 3'b010; // C (1)
                else
                    next_state = 3'b011; // D (0)
            end
        endcase
    end

    always @(posedge clk) begin
        case(state)
            3'b000: z <= 1'b0;   // A (0)
            3'b001: z <= 1'b0;   // B (0)
            3'b010: z <= 1'b1;   // C (1)
            3'b011: z <= 1'b0;   // D (0)
            3'b100: z <= 1'b1;   // E (1)
            3'b101: z <= 1'b0;   // F (1)
        endcase
    end

endmodule
