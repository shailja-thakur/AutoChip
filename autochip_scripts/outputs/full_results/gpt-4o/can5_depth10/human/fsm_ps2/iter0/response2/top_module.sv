module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    reg [1:0] state, next_state;

    // State encoding
    localparam IDLE = 2'b00;
    localparam BYTE1 = 2'b01;
    localparam BYTE2 = 2'b10;
    localparam BYTE3 = 2'b11;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3] == 1'b1)
                    next_state = BYTE1;
                else
                    next_state = IDLE;
            end
            BYTE1: next_state = BYTE2;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 1'b0;
        else if (state == BYTE3 && next_state == IDLE)
            done <= 1'b1;
        else
            done <= 1'b0;
    end

endmodule
