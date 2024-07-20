module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State declaration
    typedef enum logic [1:0] {
        IDLE = 2'd0,
        LOAD = 2'd1,
        COUNT = 2'd2,
        DONE = 2'd3
    } state_t;
    
    state_t current_state, next_state;

    reg [3:0] delay;
    reg [13:0] counter; // Maximum of (15 + 1) * 1000 = 16000 requires 14 bits
    reg [13:0] load_counter;
    reg [3:0] shifter;  // To detect the sequence 1101
    reg [1:0] bits_counter;
    
    reg [3:0] duration; // Store the duration shifted in

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @* begin
        case (current_state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                if (shifter == 4'b1101) begin
                    next_state = LOAD;
                end
                else begin
                    next_state = IDLE;
                end
            end
            LOAD: begin
                if (bits_counter == 2'd3) begin
                    next_state = COUNT;
                end
                else begin
                    next_state = LOAD;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (load_counter == 14'd0) begin
                    next_state = DONE;
                end
                else begin
                    next_state = COUNT;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = DONE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output and state update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shifter <= 4'b0;
            delay <= 4'b0;
            counter <= 14'b0;
            load_counter <= 14'b0;
            bits_counter <= 2'd0;
        end
        else begin
            case (current_state)
                IDLE: begin
                    shifter <= {shifter[2:0], data};
                    delay <= 4'b0;
                    counter <= 14'b0;
                    load_counter <= 14'b0;
                    bits_counter <= 2'd0;
                    duration <= 4'b0;
                end
                LOAD: begin
                    duration <= {duration[2:0], data};
                    bits_counter <= bits_counter + 1;
                    if (bits_counter == 2'd3) begin
                        delay <= {duration[2:0], data};
                        load_counter <= ({duration[2:0], data} + 1) * 1000;
                    end
                end
                COUNT: begin
                    if (load_counter != 14'd0) begin
                        load_counter <= load_counter - 1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        shifter <= 4'b0;
                        delay <= 4'b0;
                        counter <= 14'b0;
                        load_counter <= 14'b0;
                        bits_counter <= 2'd0;
                        duration <= 4'b0;
                    end
                end
            endcase
        end
    end

    assign count = (current_state == COUNT) ? (load_counter / 1000) : 4'b0000; // Provide appropriate bits for remaining cycles

endmodule
