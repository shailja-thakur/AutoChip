module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] shift_register;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_register <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state != DONE) begin
                shift_register <= {shift_register[15:0], in};
            end
            if (state == DONE) begin
                out_bytes <= shift_register;
            end else begin
                out_bytes <= 24'b0;
            end
            if (state == DONE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    always_comb begin
        case (state)
            BYTE1: begin
                if (in[2]) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = DONE;
            end
            DONE: begin
                if (in[2]) begin
                    next_state = BYTE2;
                end else begin
                    next_state = BYTE1;
                end
            end
            default: next_state = BYTE1;
        endcase
    end

endmodule
