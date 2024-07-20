module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        DATA = 3'd2,
        STOP = 3'd3,
        ERROR = 3'd4
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count; // Used to count the 8 data bits
    reg [7:0] data_reg;  // Register to hold the received data byte

    // State transition logic
    always @(*) begin
        // Default values
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit (0)
                    next_state = START;
                else
                    next_state = IDLE;
            end
            
            START: begin
                if (in == 1'b0)
                    next_state = DATA;
                else
                    next_state = IDLE;
            end
            
            DATA: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            
            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b1; // Byte received successfully
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
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

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            data_reg <= 8'd0;
        end else begin
            state <= next_state;
            
            // Data reception logic
            case (next_state)
                DATA: begin
                    data_reg[bit_count] <= in; // Store the incoming data bit
                    bit_count <= bit_count + 1;
                end
                
                STOP: begin
                    bit_count <= 3'd0;
                end
                
                ERROR: begin
                    bit_count <= 3'd0;
                end
                
                IDLE: begin
                    bit_count <= 3'd0;
                end
            endcase
        end
    end

endmodule
