module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State declaration
    typedef enum reg [2:0] {
        IDLE,
        PATTERN,
        DELAY,
        COUNT,
        DONE
    } state_t;
    
    state_t state, next_state;
    reg [3:0] delay;
    reg [15:0] counter;
    reg [2:0] bit_count;
    
    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 16'd0;
            delay <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
            count <= 4'd0;
            bit_count <= 3'd0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    next_state = PATTERN;
                end
                counting = 1'b0;
                done = 1'b0;
            end
            
            PATTERN: begin
                if (bit_count == 3'd3 && data == 1'b1) begin
                    next_state = DELAY;
                end
            end
            
            DELAY: begin
                if (bit_count == 3'd4) begin
                    next_state = COUNT;
                end
            end
            
            COUNT: begin
                counting = 1'b1;
                if (counter == (delay + 1) * 1000) begin
                    next_state = DONE;
                end
            end
            
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end
                done = 1'b1;
            end
        endcase
    end
    
    // Output logic and timer counting
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 16'd0;
            delay <= 4'd0;
            count <= 4'd0;
            bit_count <= 3'd0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 16'd0;
                    bit_count <= 3'd0;
                end
                
                PATTERN: begin
                    bit_count <= bit_count + 3'd1;
                    if (bit_count == 3'd3) begin
                        bit_count <= 3'd0;
                    end
                end
                
                DELAY: begin
                    delay <= {delay[2:0], data};
                    bit_count <= bit_count + 3'd1;
                    if (bit_count == 3'd4) begin
                        bit_count <= 3'd0;
                    end
                end
                
                COUNT: begin
                    counter <= counter + 16'd1;
                    count <= (counter / 1000 == 0) ? delay : delay - (counter / 1000);
                end
                
                DONE: begin
                    if (ack) begin
                        count <= 4'd0;
                    end
                end
            endcase
        end
    end
endmodule
