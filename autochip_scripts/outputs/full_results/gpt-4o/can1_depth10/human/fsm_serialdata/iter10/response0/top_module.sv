module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // FSM states
    reg [2:0] state, next_state;
    localparam IDLE = 3'b000;
    localparam START = 3'b001;
    localparam DATA = 3'b010;
    localparam STOP = 3'b011;

    reg [7:0] shift_reg;
    reg [2:0] bit_cnt;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 8'b0;
            bit_cnt <= 3'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;

            case (state)
                IDLE: begin
                    done <= 1'b0;
                end
                START: begin
                    // Stay in START until start bit (0) is confirmed
                end
                DATA: begin
                    shift_reg[bit_cnt] <= in;
                    bit_cnt <= bit_cnt + 1;
                end
                STOP: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_reg;
                        done <= 1'b0; // Will set done below after state transition
                    end else begin
                        done <= 1'b0; // Clear done since it's not an expected stop bit
                    end
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
            START: begin
                if (in == 1'b0) begin
                    next_state = DATA;
                end else begin
                    next_state = IDLE;
                end
            end
            DATA: begin
                if (bit_cnt == 3'd7) begin
                    next_state = STOP;
                end else begin
                    next_state = DATA;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                    done = 1'b1; // Set done once a valid stop bit is detected
                end else begin
                    next_state = STOP; // Wait for the correct stop bit
                    done <= 1'b0; // Clear done since it's not an expected stop bit
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
