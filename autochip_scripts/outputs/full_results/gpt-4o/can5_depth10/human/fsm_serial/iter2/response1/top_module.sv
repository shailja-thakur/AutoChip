module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // States of the FSM
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP,
        ERROR
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
        end else begin
            state <= next_state;
            if (state == DATA) bit_count <= bit_count + 1;
            else bit_count <= 3'b000;
        end
    end

    always @(*) begin
        next_state = state;
        done = 1'b0;
        case(state)
            IDLE: begin
                if (in == 1'b0) next_state = START;
            end
            
            START: begin
                next_state = DATA;
            end
            
            DATA: begin
                if (bit_count == 3'b111) next_state = STOP;
            end
            
            STOP: begin
                if (in == 1'b1) begin
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            
            ERROR: begin
                if (in == 1'b1) next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
