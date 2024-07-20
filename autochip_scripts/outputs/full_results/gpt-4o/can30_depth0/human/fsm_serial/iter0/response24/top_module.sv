module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    reg [3:0] state, next_state;
    parameter IDLE = 4'd0, START = 4'd1, BIT0 = 4'd2, BIT1 = 4'd3, BIT2 = 4'd4, BIT3 = 4'd5,
              BIT4 = 4'd6, BIT5 = 4'd7, BIT6 = 4'd8, BIT7 = 4'd9, STOP = 4'd10, ERROR = 4'd11;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE:   next_state = (in == 1'b0) ? START : IDLE;
            START:  next_state = BIT0;
            BIT0:   next_state = BIT1;
            BIT1:   next_state = BIT2;
            BIT2:   next_state = BIT3;
            BIT3:   next_state = BIT4;
            BIT4:   next_state = BIT5;
            BIT5:   next_state = BIT6;
            BIT6:   next_state = BIT7;
            BIT7:   next_state = STOP;
            STOP:   next_state = (in == 1'b1) ? IDLE : ERROR;
            ERROR:  next_state = (in == 1'b1) ? IDLE : ERROR;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            done <= 1'b0;
        else if (state == STOP && in == 1'b1)
            done <= 1'b1;
        else if (state == ERROR)
            done <= 1'b0;
        else
            done <= 1'b0;
    end

endmodule
