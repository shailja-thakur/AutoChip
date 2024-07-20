module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
        end else begin
            state <= next_state;
            if (state == DATA)
                bit_count <= bit_count + 1;
            else
                bit_count <= 3'b000;
        end
    end

    always @(*) begin
        done = 0;
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START;
            end
            
            START: begin
                next_state = DATA;
            end
            
            DATA: begin
                if (bit_count == 3'b111) // All 8 data bits received
                    next_state = STOP;
            end
            
            STOP: begin
                if (in == 1) begin // Correct stop bit detected
                    done = 1;
                    next_state = IDLE;
                end else
                    next_state = ERROR;
            end
            
            ERROR: begin
                if (in == 1)
                    next_state = IDLE; // Wait for a valid stop bit to start again
            end
        endcase
    end
endmodule
