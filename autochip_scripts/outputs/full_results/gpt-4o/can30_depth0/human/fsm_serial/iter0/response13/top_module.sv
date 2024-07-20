module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [3:0] {
        IDLE         = 4'b0000,
        START        = 4'b0001,
        DATA_BIT_0   = 4'b0010,
        DATA_BIT_1   = 4'b0011,
        DATA_BIT_2   = 4'b0100,
        DATA_BIT_3   = 4'b0101,
        DATA_BIT_4   = 4'b0110,
        DATA_BIT_5   = 4'b0111,
        DATA_BIT_6   = 4'b1000,
        DATA_BIT_7   = 4'b1001,
        STOP         = 4'b1010,
        WAIT_STOP    = 4'b1011
    } state_t;

    state_t state, next_state;
    reg [7:0] data;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        done = 0;

        case (state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START;
                end
            end
            
            START: begin
                next_state = DATA_BIT_0;
            end
            
            DATA_BIT_0: begin
                next_state = DATA_BIT_1;
            end
            
            DATA_BIT_1: begin
                next_state = DATA_BIT_2;
            end
            
            DATA_BIT_2: begin
                next_state = DATA_BIT_3;
            end
            
            DATA_BIT_3: begin
                next_state = DATA_BIT_4;
            end
            
            DATA_BIT_4: begin
                next_state = DATA_BIT_5;
            end
            
            DATA_BIT_5: begin
                next_state = DATA_BIT_6;
            end
            
            DATA_BIT_6: begin
                next_state = DATA_BIT_7;
            end
            
            DATA_BIT_7: begin
                next_state = STOP;
            end
            
            STOP: begin
                if (in == 1) begin
                    done = 1;
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_STOP;
                end
            end
            
            WAIT_STOP: begin
                if (in == 1) begin
                    next_state = IDLE;
                end
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Data reception
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data <= 8'h00;
        end else begin
            case (state)
                DATA_BIT_0: data[0] <= in;
                DATA_BIT_1: data[1] <= in;
                DATA_BIT_2: data[2] <= in;
                DATA_BIT_3: data[3] <= in;
                DATA_BIT_4: data[4] <= in;
                DATA_BIT_5: data[5] <= in;
                DATA_BIT_6: data[6] <= in;
                DATA_BIT_7: data[7] <= in;
                default: data <= data;
            endcase
        end
    end
endmodule
