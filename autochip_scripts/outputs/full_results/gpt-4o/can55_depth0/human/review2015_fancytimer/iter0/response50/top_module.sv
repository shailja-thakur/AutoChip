module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    localparam [2:0] 
        IDLE = 3'b000,
        DETECT1 = 3'b001,
        DETECT2 = 3'b010,
        DETECT3 = 3'b011,
        DETECT4 = 3'b100,
        LOAD_DELAY = 3'b101,
        COUNT = 3'b110,
        WAIT_ACK = 3'b111;

    reg [2:0] state, next_state;
    reg [3:0] delay, delay_counter;
    reg [9:0] counter; // Can count up to 1000
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            counter <= 0;
            delay <= 0;
            delay_counter <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: 
                if (data == 1) next_state = DETECT1;
                
            DETECT1: 
                if (data == 1) next_state = DETECT2;
                else next_state = IDLE;
            
            DETECT2: 
                if (data == 0) next_state = DETECT3;
                else next_state = IDLE;

            DETECT3: 
                if (data == 1) next_state = DETECT4;
                else next_state = IDLE;

            DETECT4: 
                next_state = LOAD_DELAY;
                
            LOAD_DELAY: begin
                next_state = COUNT;
                delay_counter[3:0] = {delay_counter[2:0], data};
            end

            COUNT: 
                if (counter == 1000) begin
                    if (delay_counter == 0) next_state = WAIT_ACK;
                    else begin
                        delay_counter = delay_counter - 1;
                        counter = 0;
                    end
                end
                
            WAIT_ACK:
                if (ack) begin
                    next_state = IDLE;
                end
                
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            counter <= 0;
            counting <= 0;
            done <= 0;
            delay <= 0;
        end

        case (state)
            IDLE: begin
                counting <= 0;
                done <= 0;
                counter <= 0;
                delay <= 0;
            end
            
            WAIT_ACK: begin
                counting <= 0;
                done <= 1;
            end

            LOAD_DELAY: begin
                delay[3:0] <= {delay[2:0], data};
                counter <= 0;
            end

            COUNT: begin
                counting <= 1;
                if (counter < 1000) begin
                    counter <= counter + 1;
                end
            end
        endcase
    end
    
    assign count[3:0] = delay[3:0];

endmodule
