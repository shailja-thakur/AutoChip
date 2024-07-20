module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP,
        CHECKSTOP
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            out_byte <= 8'b0;
            done <= 0;
            bit_count <= 0;
            data_reg <= 8'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next-state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
                done = 0;
            end
            
            START: begin
                next_state = DATA;
                done = 0;
            end
            
            DATA: begin
                if (bit_count == 3'd7)
                    next_state = CHECKSTOP;
                else
                    next_state = DATA;
                done = 0;
            end
            
            CHECKSTOP: begin
                if (in == 1)  // Stop bit must be 1
                    next_state = STOP;
                else
                    next_state = IDLE;
                done = 0;
            end
            
            STOP: begin
                next_state = IDLE;
                done = 1;
            end
            
            default: begin
                next_state = IDLE;
                done = 0;
            end
        endcase
    end

    // Output and register update logic
    always @(posedge clk) begin
        if (reset) begin
            bit_count <= 0;
            data_reg <= 0;
            out_byte <= 0;
        end else begin
            case (state)
                IDLE: begin
                    bit_count <= 0;
                    data_reg <= 0;
                end

                START: begin
                    bit_count <= 0;
                    data_reg <= 0;
                end

                DATA: begin
                    data_reg[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end

                CHECKSTOP: begin
                    if (in == 1) begin
                        out_byte <= data_reg;
                    end
                end

                STOP: begin
                    // out_byte and done are set accordingly
                end

                default: begin
                    bit_count <= 0;
                    data_reg <= 0;
                end
            endcase
        end
    end

endmodule
