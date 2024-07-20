module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE       = 3'd0,
        START_BIT  = 3'd1,
        DATA_BITS  = 3'd2,
        STOP_BIT   = 3'd3,
        ERROR      = 3'd4
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_bits;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            data_bits <= 8'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end
    
    always @(*) begin
        next_state = current_state;
        done = 1'b0;
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0) // detect start bit
                    next_state = START_BIT;
            end
            
            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 3'd0;
            end
            
            DATA_BITS: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP_BIT;
                end else begin
                    next_state = DATA_BITS;
                    bit_count = bit_count + 3'd1;
                end
            end
            
            STOP_BIT: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end
    
    always @(posedge clk) begin
        if (current_state == DATA_BITS) begin
            data_bits[bit_count] <= in;
        end
    end

endmodule
