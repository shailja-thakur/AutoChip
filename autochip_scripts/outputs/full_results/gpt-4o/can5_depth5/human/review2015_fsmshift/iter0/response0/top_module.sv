module top_module(
	input clk,
	input reset,
	output shift_ena);

    reg [2:0] state, next_state;

    // State definitions
    localparam IDLE = 3'b000;
    localparam COUNT_1 = 3'b001;
    localparam COUNT_2 = 3'b010;
    localparam COUNT_3 = 3'b011;
    localparam COUNT_4 = 3'b100;

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= COUNT_1;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: next_state = IDLE;
            COUNT_1: next_state = COUNT_2;
            COUNT_2: next_state = COUNT_3;
            COUNT_3: next_state = COUNT_4;
            COUNT_4: next_state = IDLE;
            default: next_state = IDLE; // default case to handle unexpected states
        endcase
    end

    // Output logic
    assign shift_ena = (state == COUNT_1 || state == COUNT_2 || state == COUNT_3 || state == COUNT_4);

endmodule
