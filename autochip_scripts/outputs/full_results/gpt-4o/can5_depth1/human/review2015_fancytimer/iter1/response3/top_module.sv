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
    reg [3:0] shifter;  // To detect the sequence 1101
    reg [3:0] delay_count;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @* begin
        next_state = current_state;
        done = 1'b0;
        counting = 1'b0;
        case (current_state)
            IDLE: begin
                if (shifter == 4'b1101) begin
                    next_state = LOAD;
                end
            end
            LOAD: begin
                if (delay_count == 4'd4) begin
                    next_state = COUNT;
                end
            end
            COUNT: begin
                counting = 1'b1;
                if (counter == 14'd0) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Output and state update logic
    always @(posedge clk) begin
        if (reset) begin
            shifter <= 4'b0;
            delay <= 4'b0;
            counter <= 14'b0;
            delay_count <= 4'd0;
        end
        else begin
            case (current_state)
                IDLE: begin
                    shifter <= {shifter[2:0], data};
                    delay <= 4'b0;
                    counter <= 14'b0;
                    delay_count <= 4'd0;
                end
                LOAD: begin
                    if (delay_count < 4'd4) begin
                        delay <= {delay[2:0], data};
                        delay_count <= delay_count + 1;
                    end
                    if (delay_count == 4'd3) begin
                        counter <= ({delay[2:0], data} + 1) * 1000 - 1; // Correct counter value
                    end
                end
                COUNT: begin
                    if (counter != 14'd0) begin
                        counter <= counter - 1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        shifter <= 4'b0;
                        delay <= 4'b0;
                        counter <= 14'b0;
                        delay_count <= 4'd0;
                    end
                end
            endcase
        end
    end

    assign count = (current_state == COUNT) ? counter[13:10] : 4'bz;

endmodule
