module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        START_BIT   = 3'b001,
        DATA_BITS   = 3'b010,
        STOP_BIT    = 3'b011,
        DONE        = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Data bit counter
    reg [2:0] bit_counter;
    reg [7:0] shift_reg;

    // State transition and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'b000;
            shift_reg <= 8'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;

            // Output and shift register updating
            case (current_state)
                START_BIT: begin
                    done <= 1'b0;
                end
                DATA_BITS: begin
                    if (bit_counter < 3'd7) begin
                        shift_reg <= {in, shift_reg[7:1]};
                        bit_counter <= bit_counter + 3'd1;
                    end else begin
                        shift_reg <= {in, shift_reg[7:1]};
                        bit_counter <= 3'd0;
                    end
                end
                STOP_BIT: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_reg;
                        done <= 1'b1;
                    end else begin
                        done <= 1'b0;
                    end
                end
                DONE: begin
                    done <= 1'b1;
                end
                default: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

    // Next state logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            next_state <= IDLE;
        end else begin
            case (current_state)
                IDLE: begin
                    if (in == 1'b0) begin
                        next_state <= START_BIT;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                START_BIT: begin
                    next_state <= DATA_BITS;
                end
                DATA_BITS: begin
                    if (bit_counter == 3'd7) begin
                        next_state <= STOP_BIT;
                    end else begin
                        next_state <= DATA_BITS;
                    end
                end
                STOP_BIT: begin
                    if (in == 1'b1) begin
                        next_state <= DONE;
                    end else begin
                        next_state <= IDLE;
                    end
                end
                DONE: begin
                    next_state <= IDLE;
                end
                default: begin
                    next_state <= IDLE;
                end
            endcase
        end
    end

endmodule
