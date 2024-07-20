module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        WAIT_BYTE_1 = 2'b00,
        RECEIVE_BYTE_2 = 2'b01,
        RECEIVE_BYTE_3 = 2'b10,
        DONE_STATE = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [23:0] message;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= WAIT_BYTE_1;
            done <= 1'b0;
            out_bytes <= 24'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DONE_STATE) begin
                out_bytes <= message;
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            message <= 24'b0;
        end else begin
            case (current_state)
                WAIT_BYTE_1: begin
                    if (in[3] == 1'b1) begin
                        message[23:16] <= in;
                    end
                end
                RECEIVE_BYTE_2: begin
                    message[15:8] <= in;
                end
                RECEIVE_BYTE_3: begin
                    message[7:0] <= in;
                end
                DONE_STATE: begin
                    // Do nothing
                end
            endcase
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            WAIT_BYTE_1: begin
                if (in[3] == 1'b1) begin
                    next_state = RECEIVE_BYTE_2;
                end
            end
            RECEIVE_BYTE_2: begin
                next_state = RECEIVE_BYTE_3;
            end
            RECEIVE_BYTE_3: begin
                next_state = DONE_STATE;
            end
            DONE_STATE: begin
                next_state = WAIT_BYTE_1;
            end
        endcase
    end
endmodule
