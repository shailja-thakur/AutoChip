module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        WAIT_FOR_STOP = 3'b100
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            data <= 8'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == DATA) begin
                data[bit_count] <= in;
                bit_count <= bit_count + 1;
            end
            else if (state == STOP) begin
                done <= (in == 1'b1);
            end
            else if (state == IDLE || state == WAIT_FOR_STOP) begin
                bit_count <= 3'd0;
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = WAIT_FOR_STOP;
                end
            end
            WAIT_FOR_STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
