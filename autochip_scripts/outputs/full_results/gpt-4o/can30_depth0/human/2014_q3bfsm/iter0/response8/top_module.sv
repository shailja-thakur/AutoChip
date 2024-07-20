module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            3'b000: next_state = x ? 3'b001 : 3'b000;
            3'b001: next_state = x ? 3'b100 : 3'b001;
            3'b010: next_state = x ? 3'b001 : 3'b010;
            3'b011: next_state = x ? 3'b010 : 3'b001;
            3'b100: next_state = x ? 3'b100 : 3'b011;
            default: next_state = 3'b000;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            3'b000: z = 0;
            3'b001: z = 0;
            3'b010: z = 0;
            3'b011: z = 1;
            3'b100: z = 1;
            default: z = 0;
        endcase
    end

endmodule
