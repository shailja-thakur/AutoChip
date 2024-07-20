module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE,
        START,
        RECEIVE,
        STOP,
        DONE,
        ERROR
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_byte;
    
    // Synchronous state update and data shift in process
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            data_byte <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == RECEIVE) begin
                data_byte[bit_count] <= in;
                bit_count <= bit_count + 1;
            end
            else if (state == DONE || state == ERROR) begin
                bit_count <= 3'd0;
            end
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
            end
            START: begin
                next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = DONE;
                    out_byte = data_byte;
                    done = 1'b1;
                end
                else begin
                    next_state = ERROR;
                end
            end
            DONE: begin
                if (in == 1'b1)
                    next_state = IDLE;
            end
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
