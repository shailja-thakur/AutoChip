module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        READ_PATTERN = 3'b001,
        READ_DELAY = 3'b010,
        COUNTING = 3'b011,
        DONE = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [3:0] delay;
    reg [3:0] delay_shift;
    reg [13:0] counter; // 14-bit counter for 1000*8=8000 clock cycles max

    // Output logic for count
    assign count = (state == COUNTING) ? delay_shift : 4'bxxxx; // Don't-care when not counting
    
    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = READ_PATTERN;
                end
            end
            READ_PATTERN: begin
                if (data == 1'b1) begin
                    next_state = READ_DELAY;
                end
            end
            READ_DELAY: begin
                if (delay_shift == 4'b1111) begin // Have read 4 bits for delay
                    next_state = COUNTING;
                end
            end
            COUNTING: begin
                if (counter == 14'b0) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = READ_PATTERN;
                end
            end
        endcase
    end
    
    // Output logic and counter management
    always @(posedge clk) begin
        if (reset) begin
            counting <= 1'b0;
            done <= 1'b0;
            delay_shift <= 4'b0000;
            counter <= 14'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    counting <= 1'b0;
                    delay_shift <= 4'b0000;
                end
                READ_PATTERN: begin
                    delay_shift <= {delay_shift[2:0], data};
                end
                READ_DELAY: begin
                    delay <= delay_shift;
                    counter <= (delay_shift + 1) * 1000;
                    delay_shift <= {delay_shift[2:0], data};
                end
                COUNTING: begin
                    counting <= 1'b1;
                    counter <= counter - 1;
                    if (counter % 1000 == 0) begin
                        delay_shift <= delay_shift - 1;
                    end
                end
                DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                end
            endcase
        end
    end
endmodule
