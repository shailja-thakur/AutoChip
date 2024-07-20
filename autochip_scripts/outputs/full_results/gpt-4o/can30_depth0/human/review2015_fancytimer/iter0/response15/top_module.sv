module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    typedef enum logic [2:0] {
        IDLE     = 3'b000,
        DETECT   = 3'b001,
        LOAD     = 3'b010,
        COUNT    = 3'b011,
        NOTIFY   = 3'b100,
        WAIT_ACK = 3'b101
    } state_t;
    
    state_t state, next_state;
    
    reg [3:0] delay;
    reg [12:0] cycle_counter;
    reg [3:0] input_buffer;
    integer i;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            count <= 4'bxxxx;
            cycle_counter <= 0;
            delay <= 0;
            input_buffer <= 4'b0000;
        end else begin
            state <= next_state;
        end
    end
    
    always_ff @(posedge clk) begin
        if (state == DETECT) begin
            input_buffer <= {input_buffer[2:0], data};
        end
    end
    
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = DETECT;
                end else begin
                    next_state = IDLE;
                end
            end
            DETECT: begin
                if (input_buffer == 4'b1101) begin
                    next_state = LOAD;
                    delay = 0;
                end
            end
            LOAD: begin
                delay[3] = data;
                i = 1;
                for (i = 1; i<4; i = i + 1)begin
                    delay[3-i] = data;
                    if (i==3) begin
                        next_state = COUNT;
                        cycle_counter = (delay + 1) * 1000;
                        count = delay;
                        counting = 1'b1;
                    end 
                end
            end
            COUNT: begin
                if (cycle_counter > 0) begin
                    cycle_counter = cycle_counter - 1;
                    if (cycle_counter % 1000 == 0) begin
                        count = count - 1;
                    end
                end else begin
                    count = 4'bxxxx;
                    counting = 0;
                    next_state = NOTIFY;
                end
            end
            NOTIFY: begin
                done = 1'b1;
                if (ack) begin
                    done = 0;
                    next_state = DETECT;
                end
            end
        endcase
    end
endmodule
