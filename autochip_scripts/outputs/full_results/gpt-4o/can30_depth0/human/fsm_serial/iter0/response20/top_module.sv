module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    // State encoding
    typedef enum logic [3:0] {
        IDLE = 4'd0,
        START_BIT = 4'd1,
        BIT0 = 4'd2,
        BIT1 = 4'd3,
        BIT2 = 4'd4,
        BIT3 = 4'd5,
        BIT4 = 4'd6,
        BIT5 = 4'd7,
        BIT6 = 4'd8,
        BIT7 = 4'd9,
        STOP_BIT = 4'd10,
        ERROR = 4'd11 // Error state if stop bit is not correct
    } state_t;

    state_t state, next_state;
    logic [2:0] bit_count;  // To keep track of the number of bits received

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            bit_count <= 3'd0;
        else if (state == START_BIT || state == BIT0 || state == BIT1 || state == BIT2 || state == BIT3 || state == BIT4 || state == BIT5 || state == BIT6 || state == BIT7)
            bit_count <= bit_count + 1;
        else
            bit_count <= 3'd0;
    end

    always_comb begin
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in == 1'b0)  // Detect start bit
                    next_state = START_BIT;
            end
            START_BIT: begin
                next_state = BIT0;
            end
            BIT0: begin
                next_state = BIT1;
            end
            BIT1: begin
                next_state = BIT2;
            end
            BIT2: begin
                next_state = BIT3;
            end
            BIT3: begin
                next_state = BIT4;
            end
            BIT4: begin
                next_state = BIT5;
            end
            BIT5: begin
                next_state = BIT6;
            end
            BIT6: begin
                next_state = BIT7;
            end
            BIT7: begin
                next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end
                else
                    next_state = ERROR;
            end    
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
