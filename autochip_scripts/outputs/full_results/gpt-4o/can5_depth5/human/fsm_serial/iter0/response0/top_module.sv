module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP,
        DONE
    } state_t;
    
    state_t state, next_state;
    reg [3:0] bit_count;
    reg [7:0] data;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 0;
            data <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == START || state == DATA) begin
                bit_count <= bit_count + 1;
            end else if (state == DONE || state == STOP) begin
                bit_count <= 0;
            end
            if (state == DATA) begin
                data <= {in, data[7:1]};
            end
            if (state == DONE) begin
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START;
                end
            end
            START: begin
                if (bit_count == 4'd1) begin
                    next_state = DATA;
                end
            end
            DATA: begin
                if (bit_count == 4'd9) begin
                    next_state = in ? STOP : IDLE; // Expecting stop bit
                end
            end
            STOP: begin
                if (in) begin
                    next_state = DONE;
                end else begin
                    next_state = IDLE;
                end
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
