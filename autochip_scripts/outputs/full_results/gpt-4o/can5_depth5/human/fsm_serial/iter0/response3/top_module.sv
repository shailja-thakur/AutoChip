module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // States of the FSM
    typedef enum logic [3:0] {
        IDLE      = 4'b0000,
        START     = 4'b0001,
        BIT0      = 4'b0010,
        BIT1      = 4'b0011,
        BIT2      = 4'b0100,
        BIT3      = 4'b0101,
        BIT4      = 4'b0110,
        BIT5      = 4'b0111,
        BIT6      = 4'b1000,
        BIT7      = 4'b1001,
        STOP      = 4'b1010,
        WAIT_IDLE = 4'b1011
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == IDLE) done <= 1'b0;
        end
    end
    
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) next_state = START;
            end
            START: begin
                next_state = BIT0;
            end
            BIT0: begin
                if (bit_counter == 3'd0) next_state = BIT1; 
            end
            BIT1: begin
                if (bit_counter == 3'd1) next_state = BIT2; 
            end
            BIT2: begin
                if (bit_counter == 3'd2) next_state = BIT3;
            end
            BIT3: begin
                if (bit_counter == 3'd3) next_state = BIT4;
            end
            BIT4: begin
                if (bit_counter == 3'd4) next_state = BIT5;
            end
            BIT5: begin
                if (bit_counter == 3'd5) next_state = BIT6;
            end
            BIT6: begin
                if (bit_counter == 3'd6) next_state = BIT7;
            end
            BIT7: begin
                if (bit_counter == 3'd7) next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) next_state = IDLE;
                else next_state = WAIT_IDLE;
                done = 1'b1;
            end
            WAIT_IDLE: begin
                if (in == 1'b1) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) bit_counter <= 3'b0;
        else if (state >= BIT0 && state <= BIT7) bit_counter <= bit_counter + 1;
        else bit_counter <= 3'b0;
    end
    
endmodule
