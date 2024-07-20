module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // Define state encoding
    typedef enum reg [1:0] {
        BYTE1, BYTE2, BYTE3, DONE
    } state_t;

    state_t state, next_state;
    reg [23:0] shift_register;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_register <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state == BYTE2 || next_state == BYTE3 || next_state == DONE) begin
                shift_register <= {shift_register[15:0], in}; // Shift left by 8 bits and load new byte
            end
        end
    end

    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[2] == 1'b1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end

            BYTE2: begin
                next_state = BYTE3;
            end

            BYTE3: begin
                next_state = DONE;
            end

            DONE: begin
                if (in[2] == 1'b0)
                    next_state = BYTE1;
                else
                    next_state = DONE;
            end

            default: begin
                next_state = BYTE1;
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end else if (state == DONE) begin
            out_bytes <= shift_register;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 1'b0;
        end else if (state == DONE) begin
            done <= 1'b1;
        end else begin
            done <= 1'b0;
        end
    end

endmodule
