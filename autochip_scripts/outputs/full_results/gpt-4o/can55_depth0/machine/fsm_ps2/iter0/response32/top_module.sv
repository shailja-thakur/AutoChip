module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    reg [1:0] state, next_state;
    reg done_reg;

    // State encoding
    parameter BYTE1 = 2'b00;
    parameter BYTE2 = 2'b01;
    parameter BYTE3 = 2'b10;
    parameter DONE  = 2'b11;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[2] == 1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (in[2] == 0)
                    next_state = BYTE1;
                else
                    next_state = BYTE2;
            end
            default: next_state = BYTE1;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            done_reg <= 0;
        else if (state == DONE)
            done_reg <= 1;
        else
            done_reg <= 0;
    end

    assign done = done_reg;

endmodule
