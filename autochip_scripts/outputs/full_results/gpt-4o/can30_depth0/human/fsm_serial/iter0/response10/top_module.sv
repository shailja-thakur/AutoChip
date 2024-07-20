module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // State encoding
    typedef enum logic [2:0] {
        IDLE     = 3'b000,
        START    = 3'b001,
        DATA     = 3'b010,
        STOP     = 3'b011,
        ERROR    = 3'b100
    } state_t;

    // Signals
    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;

    // State transitions
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            data_reg <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_count <= bit_count + 1;
                data_reg <= {in, data_reg[7:1]};
            end else if (current_state != DATA) begin
                bit_count <= 0;
            end
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        done = 0;

        case (current_state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START;
                end
            end

            START: begin
                if (in == 0) begin
                    next_state = DATA;
                end else begin
                    next_state = IDLE; // False trigger, go back to IDLE
                end
            end

            DATA: begin
                if (bit_count == 3'd7) begin
                    next_state = STOP;
                end
            end

            STOP: begin
                if (in == 1) begin
                    next_state = IDLE;
                    done = 1;
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
endmodule
