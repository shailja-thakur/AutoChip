module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // Definition of States
    typedef enum logic [2:0] {
        WAIT_PATTERN,      // Waiting for 1101 pattern
        READ_DELAY,        // Reading the delay bits
        COUNTING,          // Counting state
        DONE               // Done state, waiting for ack
    } state_t;

    state_t current_state, next_state;
    reg [3:0] delay;
    reg [12:0] counter;
    reg [3:0] shift_reg;

    // Synchronous state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= WAIT_PATTERN;
        else
            current_state <= next_state;
    end

    // State transitions and output logic
    always @(*) begin
        case (current_state)
            WAIT_PATTERN: begin
                if (shift_reg == 4'b1101)
                    next_state = READ_DELAY;
                else
                    next_state = WAIT_PATTERN;
            end

            READ_DELAY: begin
                if (shift_reg[3:0] == 4'b1111)  // Assuming 4 bits have been shifted in
                    next_state = COUNTING;
                else
                    next_state = READ_DELAY;
            end

            COUNTING: begin
                if (counter == 13'd0)
                    next_state = DONE;
                else
                    next_state = COUNTING;
            end

            DONE: begin
                if (ack)
                    next_state = WAIT_PATTERN;
                else
                    next_state = DONE;
            end

            default: next_state = WAIT_PATTERN;
        endcase
    end

    // Synchronous operations within each state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'd0;
            delay <= 4'd0;
            counter <= 13'd0;
            shift_reg <= 4'd0;
        end else begin
            case (current_state)
                WAIT_PATTERN: begin
                    // Shift in the data bits and detect 1101 pattern
                    shift_reg <= {shift_reg[2:0], data};
                end

                READ_DELAY: begin
                    // Shift in the delay bits
                    shift_reg <= {shift_reg[2:0], data};
                    delay <= shift_reg[3:0];
                end

                COUNTING: begin
                    counting <= 1'b1;
                    if (counter > 13'd0)
                        counter <= counter - 1;
                    if (counter[2:0] == 3'b000)  // Decrement count every 1000 cycles
                        count <= count - 1;
                end

                DONE: begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    if (ack) begin
                        done <= 1'b0;
                        count <= 4'd0;
                        delay <= 4'd0;
                        counter <= 13'd0;
                    end
                end

                default: begin
                    count <= 4'd0;
                    delay <= 4'd0;
                    counter <= 13'd0;
                end
            endcase
        end
    end
endmodule
