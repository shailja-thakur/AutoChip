module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // FSM states
    typedef enum logic [3:0] {
        IDLE,
        START,
        BIT0,
        BIT1,
        BIT2,
        BIT3,
        BIT4,
        BIT5,
        BIT6,
        BIT7,
        STOP
    } state_t;
    
    state_t current_state, next_state;
    reg [7:0] data_byte;
    reg [2:0] bit_count;
    
    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    // Output and next state logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out_byte <= 8'd0;
            data_byte <= 8'd0;
            done <= 1'b0;
            bit_count <= 3'b0;
        end
        else begin
            case (current_state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0)
                        next_state <= START;
                    else
                        next_state <= IDLE;
                end
                START: begin
                    if (in == 1'b0)
                        next_state <= BIT0;
                    else
                        next_state <= IDLE;  // Not a valid start bit, stay in idle
                end
                BIT0: begin
                    data_byte[0] <= in;
                    next_state <= BIT1;
                end
                BIT1: begin
                    data_byte[1] <= in;
                    next_state <= BIT2;
                end
                BIT2: begin
                    data_byte[2] <= in;
                    next_state <= BIT3;
                end
                BIT3: begin
                    data_byte[3] <= in;
                    next_state <= BIT4;
                end
                BIT4: begin
                    data_byte[4] <= in;
                    next_state <= BIT5;
                end
                BIT5: begin
                    data_byte[5] <= in;
                    next_state <= BIT6;
                end
                BIT6: begin
                    data_byte[6] <= in;
                    next_state <= BIT7;
                end
                BIT7: begin
                    data_byte[7] <= in;
                    next_state <= STOP;
                end
                STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= data_byte;
                        done <= 1'b1;
                        next_state <= IDLE;
                    end
                    else begin
                        next_state <= STOP;  // Wait for the correct stop bit before transitioning
                        done <= 1'b0;
                    end
                end
                default: next_state <= IDLE;
            endcase
        end
    end
    
    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: if (in == 1'b1) next_state = IDLE;
            START: if (in == 1'b0) next_state = BIT0;
            BIT0: next_state = BIT1;
            BIT1: next_state = BIT2;
            BIT2: next_state = BIT3;
            BIT3: next_state = BIT4;
            BIT4: next_state = BIT5;
            BIT5: next_state = BIT6;
            BIT6: next_state = BIT7;
            BIT7: next_state = STOP;
            STOP: if (in == 1'b1) next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
endmodule
