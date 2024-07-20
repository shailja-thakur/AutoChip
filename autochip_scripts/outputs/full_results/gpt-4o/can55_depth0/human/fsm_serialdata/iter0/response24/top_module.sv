module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // FSM states
    typedef enum reg [3:0] {
        IDLE, START, RECEIVE, STOP
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] temp_byte;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'd0;
            out_byte <= 8'd0;
            temp_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            
            if (current_state == RECEIVE) bit_count <= bit_count + 3'd1;
            if (next_state == IDLE) bit_count <= 3'd0;
            if (next_state == STOP && current_state == STOP) bit_count <= 3'd0;

            if (next_state == RECEIVE) temp_byte[bit_count] <= in;
            if (next_state == STOP && current_state == STOP) done <= 1'b1;
            else done <= 1'b0;
        end
    end

    always @ (*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 1'b0)   // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 3'd7)  // Finished receiving 8 bits
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin  // Detect stop bit
                    out_byte = temp_byte;
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
