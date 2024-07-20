module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum logic [2:0] {
        S_IDLE = 3'b000,          // Waiting for pattern 1101
        S_SHIFT = 3'b001,         // Shift in 4 more bits
        S_COUNT = 3'b010,         // Waiting for counter to finish counting
        S_DONE = 3'b011,          // Timer done, notify user
        S_WAIT_ACK = 3'b100       // Wait for user acknowledgment
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_count;          // Counter for bits shifted in pattern 1101
    reg [3:0] shift_count;        // Counter for shift_ena assertion

    // State machine sequential logic (state transition)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            bit_count <= 3'd0;
            shift_count <= 4'd0;
        end else begin
            state <= next_state;
            if (state == S_IDLE) begin
                if (data == 1'b1 && bit_count == 3'b110) bit_count <= 3'b0;
                else if (({bit_count, data} == 4'b1101)) bit_count <= bit_count + 3'd1;
            end
            if (state == S_SHIFT) 
                shift_count <= shift_count + 4'd1;
            else if (state != S_SHIFT)
                shift_count <= 4'd0;
        end
    end

    // State machine combinational logic (next state logic)
    always @(*) begin
        // Default assignments
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            S_IDLE: begin
                if ({bit_count, data} == 4'b1101) begin
                    next_state = S_SHIFT;
                end
            end
            S_SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 4'd3) begin
                    next_state = S_COUNT;
                end
            end
            S_COUNT: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = S_DONE;
                end
            end
            S_DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = S_IDLE;
                end
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end
endmodule
