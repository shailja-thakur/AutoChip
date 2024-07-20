module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State Encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            shift_reg <= 8'd0;
            done <= 1'b0;
            out_byte <= 8'd0;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                shift_reg <= {in, shift_reg[7:1]};
                bit_count <= bit_count + 3'd1;
            end else if (state == IDLE) begin
                bit_count <= 3'd0;
            end
        end
    end

    always_comb begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) begin
                    out_byte = shift_reg;
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE;
            end
        endcase
    end

endmodule
