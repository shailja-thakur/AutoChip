module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011,
        ERROR = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            data_reg <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            
            if (current_state == DATA_BITS) begin
                data_reg[bit_count] <= in;
                bit_count <= bit_count + 1;
            end else if (current_state == STOP_BIT) begin
                out_byte <= data_reg;
                done <= 1'b1;
            end else begin
                bit_count <= 3'd0;
                done <= 1'b0;
            end
        end
    end
    
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            
            START_BIT: begin
                next_state = DATA_BITS;
            end
            
            DATA_BITS: begin
                if (bit_count < 3'd7)
                    next_state = DATA_BITS;
                else
                    next_state = STOP_BIT;
            end
            
            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule
