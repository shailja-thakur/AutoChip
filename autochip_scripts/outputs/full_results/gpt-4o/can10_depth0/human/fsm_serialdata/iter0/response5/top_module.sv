module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum reg [2:0] {
        IDLE  = 3'd0,
        START = 3'd1,
        DATA  = 3'd2,
        STOP  = 3'd3,
        DONE  = 3'd4
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count; // Count the number of data bits received
    reg [7:0] data_byte;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            data_byte <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            if (state == DATA && next_state == DATA) begin
                bit_count <= bit_count + 1;
                data_byte <= {in, data_byte[7:1]}; // Shift in the data bits (LSB first)
            end else if (state != DATA) begin
                bit_count <= 3'd0;
            end

            if (state == STOP && next_state == DONE) begin
                out_byte <= data_byte;
            end

            if (next_state == DONE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 1'b0)                    // Detecting start bit (0)
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'd7)            // After 8 bits of data
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1)                   // Detecting stop bit (1)
                    next_state = DONE;
                else
                    next_state = IDLE;            // If stop bit is not correct, go back to IDLE
            end
            DONE: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
