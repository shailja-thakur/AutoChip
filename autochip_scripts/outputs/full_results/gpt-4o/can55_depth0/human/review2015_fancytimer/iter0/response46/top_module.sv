module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum reg [2:0] {
        IDLE,
        DETECT_1, 
        DETECT_11, 
        DETECT_110, 
        DETECT_1101,
        READ_DELAY_0,
        READ_DELAY_1,
        READ_DELAY_2,
        READ_DELAY_3,
        COUNT,
        DONE
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;
    reg [12:0] count_cycles;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'd0;
            delay <= 4'd0;
            count_cycles <= 13'd0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                if (data) next_state = DETECT_1;
            end
            DETECT_1: 
                next_state = data ? DETECT_11 : IDLE;
            DETECT_11: 
                next_state = data ? DETECT_11 : DETECT_110;
            DETECT_110:
                next_state = data ? DETECT_1101 : IDLE;
            DETECT_1101: 
                next_state = READ_DELAY_0;
            READ_DELAY_0:
                next_state = READ_DELAY_1;
            READ_DELAY_1:
                next_state = READ_DELAY_2;
            READ_DELAY_2:
                next_state = READ_DELAY_3;
            READ_DELAY_3:
                next_state = COUNT;
            COUNT: begin
                counting = 1'b1;
                if (count_cycles == 13'd0) begin
                    if (count == 4'd0) next_state = DONE;
                    else count = count - 4'd1;
                end
            end
            DONE: begin
                counting = 1'b0;
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
            default:
                next_state = IDLE;
        endcase
    end

    always @(posedge clk) begin
        if (state == READ_DELAY_0) delay[3] <= data;
        else if (state == READ_DELAY_1) delay[2] <= data;
        else if (state == READ_DELAY_2) delay[1] <= data;
        else if (state == READ_DELAY_3) delay[0] <= data;
        
        if (state == COUNT) begin
            if (count_cycles == 13'd0) begin
                count_cycles <= (13'd1000 - 13'd1);
            end else begin
                count_cycles <= count_cycles - 13'd1;
            end
        end else if (state == DONE) begin
            count_cycles <= 13'd0;
        end
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'd0;
        end else if (state == COUNT && count_cycles == 13'd0) begin
            if (count == 4'd0) begin
                count <= delay;
            end else begin
                count <= count - 4'd1;
            end
        end
    end

endmodule
