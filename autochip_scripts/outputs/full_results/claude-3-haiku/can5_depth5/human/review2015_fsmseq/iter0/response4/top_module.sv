module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter [1:0] WAIT_FOR_1 = 2'b00,
                    WAIT_FOR_1_0 = 2'b01,
                    WAIT_FOR_1_0_1 = 2'b10,
                    FOUND_SEQUENCE = 2'b11;

    reg [1:0] current_state, next_state;

    always @(posedge clk) begin
        if (reset)
            current_state <= WAIT_FOR_1;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            WAIT_FOR_1: begin
                if (data == 1)
                    next_state = WAIT_FOR_1_0;
                else
                    next_state = WAIT_FOR_1;
            end
            WAIT_FOR_1_0: begin
                if (data == 0)
                    next_state = WAIT_FOR_1_0_1;
                else
                    next_state = WAIT_FOR_1;
            end
            WAIT_FOR_1_0_1: begin
                if (data == 1)
                    next_state = FOUND_SEQUENCE;
                else
                    next_state = WAIT_FOR_1;
            end
            FOUND_SEQUENCE: begin
                next_state = FOUND_SEQUENCE;
            end
            default: begin
                next_state = WAIT_FOR_1;
            end
        endcase
    end

    always @(posedge clk) begin
        if (reset)
            start_shifting <= 0;
        else if (current_state == FOUND_SEQUENCE)
            start_shifting <= 1;
    end

endmodule
