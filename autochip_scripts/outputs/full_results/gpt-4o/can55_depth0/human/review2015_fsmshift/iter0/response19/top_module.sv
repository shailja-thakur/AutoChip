module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state;
    reg [2:0] next_state;

    // State encoding
    localparam IDLE     = 3'b000;
    localparam SHIFT_1  = 3'b001;
    localparam SHIFT_2  = 3'b010;
    localparam SHIFT_3  = 3'b011;
    localparam SHIFT_4  = 3'b100;

    // Next state logic
    always @(*) begin
        case (state)
            IDLE:      next_state = reset ? SHIFT_1 : IDLE;
            SHIFT_1:   next_state = SHIFT_2;
            SHIFT_2:   next_state = SHIFT_3;
            SHIFT_3:   next_state = SHIFT_4;
            SHIFT_4:   next_state = IDLE;
            default:   next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            SHIFT_1, SHIFT_2, SHIFT_3, SHIFT_4: shift_ena = 1;
            default: shift_ena = 0;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= SHIFT_1;
        else
            state <= next_state;
    end

endmodule
