module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // Define states
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE_1 = 2'b01,
        BYTE_2 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] message;
    reg [1:0] byte_count;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            byte_count <= 2'b00;
            message <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == BYTE_1 || state == BYTE_2) begin
                byte_count <= byte_count + 1;
                message <= {message[15:0], in};
            end else if (state == DONE) begin
                byte_count <= 2'b00;
                message <= message;
                done <= 1;
            end else begin
                byte_count <= 2'b00;
                message <= 24'b0;
                done <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    next_state = BYTE_1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE_1: begin
                next_state = BYTE_2;
            end
            BYTE_2: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output assignment
    always @(posedge clk) begin
        if (state == DONE) begin
            out_bytes <= message;
        end
    end
endmodule
