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
    reg [2:0] load_count; // Count the 4 bit loading

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
        case (current_state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                next_state = (shifter == 4'b1101) ? LOAD : IDLE;
            end
            LOAD: begin
                next_state = (load_count == 3'd3) ? COUNT : LOAD; // after 4 bits are loaded
            end
            COUNT: begin
                counting = 1'b1;
                next_state = (counter == 14'd0) ? DONE : COUNT;
            end
            DONE: begin
                done = 1'b1;
                next_state = (ack) ? IDLE : DONE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output and state update logic
    always @(posedge clk) begin
        if (reset) begin
            shifter <= 4'b0;
            delay <= 4'b0;
            counter <= 14'b0;
            load_count <= 3'b0;
        end
        else begin
            case (current_state)
                IDLE: begin
                    shifter <= {shifter[2:0], data};
                    delay <= 4'b0;
                    counter <= 14'b0;
                    load_count <= 3'b0;
                end
                LOAD: begin
                    delay <= {delay[2:0], data};
                    if (load_count != 3'd3) begin
                        load_count <= load_count + 1;
                    end
                    if (load_count == 3'd3) begin
                        counter <= ({delay[2:0], data} + 1) * 1000;
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
                        load_count <= 3'b0;
                    end
                end
            endcase
        end
    end

    // Calculate count output
    assign count = (current_state == COUNT) ? (counter / 1000) : 4'bz;

endmodule
