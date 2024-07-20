module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // State encoding
    reg [2:0] state, next_state;

    // State transition
    always @(posedge clk) begin
        if (reset)
            state <= 3'b000;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            3'b000: if (x) next_state = 3'b001; else next_state = 3'b000;
            3'b001: if (x) next_state = 3'b100; else next_state = 3'b001;
            3'b010: if (x) next_state = 3'b001; else next_state = 3'b010;
            3'b011: if (x) next_state = 3'b010; else next_state = 3'b001;
            3'b100: if (x) next_state = 3'b100; else next_state = 3'b011;
            default: next_state = 3'b000;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            3'b011, 3'b100: z = 1;
            default: z = 0;
        endcase
    end

endmodule
