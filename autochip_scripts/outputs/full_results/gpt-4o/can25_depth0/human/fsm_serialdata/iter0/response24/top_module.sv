module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        DATA    = 3'b010,
        STOP    = 3'b011,
        ERROR   = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        done = 0;
        case (state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START;
                end
            end
            START: begin
                if (in == 0) begin
                    next_state = DATA;
                end else begin
                    next_state = IDLE;
                end
            end
            DATA: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1) begin
                    done = 1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Output and counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'd0;
            data <= 8'd0;
            out_byte <= 8'd0;
        end else begin
            case (state)
                IDLE: begin
                    bit_count <= 3'd0;
                    data <= 8'd0;
                end
                START: begin
                    bit_count <= 3'd0;
                end
                DATA: begin
                    data <= {in, data[7:1]};
                    bit_count <= bit_count + 3'd1;
                end
                STOP: begin
                    out_byte <= data;
                end
                ERROR: begin
                    bit_count <= 3'd0;
                    data <= 8'd0;
                end
            endcase
        end
    end
endmodule
