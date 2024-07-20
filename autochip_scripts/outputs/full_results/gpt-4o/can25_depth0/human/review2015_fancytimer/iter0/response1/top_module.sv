module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    localparam  IDLE = 3'b000,
                DETECT_PATTERN = 3'b001,
                LOAD_DELAY = 3'b010,
                COUNTDOWN = 3'b011,
                WAIT_ACK = 3'b100;

    reg [2:0] state, next_state;
    reg [3:0] bit_count;
    reg [3:0] delay;
    reg [3:0] delay_reg;
    reg [12:0] cycle_count;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            bit_count <= 4'b0;
            delay <= 4'b0;
            delay_reg <= 4'b0;
            cycle_count <= 13'd0;
        end else begin
            state <= next_state;
            
            if (state == DETECT_PATTERN) begin
                bit_count <= (data) ? (bit_count + 1) : 4'b0;
                
                if (bit_count == 3) begin
                   delay <= 0;
                end
            end
            
            if (state == LOAD_DELAY) begin
                delay <= {delay[2:0], data};
                bit_count <= bit_count + 1;
                
                if (bit_count == 7) begin
                    delay_reg <= {delay[2:0], data};  // delay[3:0] is loaded
                end
            end
            
            if (state == COUNTDOWN) begin
                if (cycle_count == 13'd999) begin
                    cycle_count <= 13'd0;
                    
                    if (count == 0) begin
                        count <= 4'b0;
                    end else begin
                        count <= count - 1;
                    end
                end else begin
                    cycle_count <= cycle_count + 1;
                end
            end
            
            if (state == WAIT_ACK && ack) begin
                done <= 1'b0;
            end
        end
    end
    
    always @(*) begin
        case (state)
            IDLE: begin
                next_state = DETECT_PATTERN;
                counting = 1'b0;
                done = 1'b0;
            end
            
            DETECT_PATTERN: begin
                if (bit_count == 4 && data == 1) begin
                    next_state = LOAD_DELAY;
                end else begin
                    next_state = DETECT_PATTERN;
                end
            end
            
            LOAD_DELAY: begin
                if (bit_count == 7) begin
                    next_state = COUNTDOWN;
                end else begin
                    next_state = LOAD_DELAY;
                end
            end
            
            COUNTDOWN: begin
                counting = (delay_reg != 0 || cycle_count < 13'd999);
                
                if (delay_reg == 0 && cycle_count == 13'd999) begin
                    next_state = WAIT_ACK;
                end else begin
                    next_state = COUNTDOWN;
                end
            end
            
            WAIT_ACK: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_ACK;
                end
            end
            
            default: next_state = IDLE;
        endcase
    end
    
endmodule
