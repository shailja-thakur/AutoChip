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
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] shift_reg;

    // State machine sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state == BYTE1) begin
                shift_reg <= {shift_reg[15:0], in};
            end else begin
                shift_reg <= {shift_reg[15:0], in};
            end

            if (next_state == DONE) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // State machine combinatorial logic
    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[2] == 1'b1) begin
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
                if (in[2] == 1'b1) begin
                    next_state = BYTE1;
                end else begin
                    next_state = BYTE1;
                end
            end
            default: begin
                next_state = BYTE1;
            end
        endcase
    end

    // Out bytes output
    always @(posedge clk) begin
        if (done) begin
            out_bytes <= shift_reg;
        end
    end

endmodule
