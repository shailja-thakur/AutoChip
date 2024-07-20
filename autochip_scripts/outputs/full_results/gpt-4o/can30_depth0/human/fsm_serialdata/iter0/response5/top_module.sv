module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        DATA = 3'd2,
        STOP = 3'd3
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'd0;
            data_reg <= 8'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            if (state == START) begin
                bit_count <= 3'd0;
            end else if (state == DATA) begin
                bit_count <= bit_count + 3'd1;
                data_reg <= {in, data_reg[7:1]};
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
                done = 1'b0;
            end
            START: begin
                if (in == 1'b0) begin
                    next_state = DATA;
                end else begin
                    next_state = IDLE;
                end
                done = 1'b0;
            end
            DATA: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
                done = 1'b0;
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                    out_byte = data_reg;
                    done = 1'b1;
                end else begin
                    next_state = STOP;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
