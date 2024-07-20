module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    reg [3:0] state, next_state;
    reg [2:0] bit_count;
    reg [7:0] shift_reg;

    // State encoding
    localparam IDLE      = 4'd0;
    localparam START_BIT = 4'd1;
    localparam DATA_BITS = 4'd2;
    localparam STOP_BIT  = 4'd3;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detected start bit
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end

            START_BIT: begin
                next_state = DATA_BITS;
            end

            DATA_BITS: begin
                if (bit_count == 3'd7)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end

            STOP_BIT: begin
                if (in == 1'b1) // Detected stop bit
                    next_state = IDLE;
                else
                    next_state = STOP_BIT;
            end

            default: next_state = IDLE;
        endcase
    end

    // Output logic and data capturing
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'd0;
            shift_reg <= 8'd0;
            done <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    bit_count <= 3'd0;
                    done <= 1'b0;
                end

                START_BIT: begin
                    done <= 1'b0;
                end

                DATA_BITS: begin
                    shift_reg[bit_count] <= in;
                    bit_count <= bit_count + 3'd1;
                    done <= 1'b0;
                end

                STOP_BIT: begin
                    if (in == 1'b1) begin
                        out_byte <= shift_reg;
                        done <= 1'b1;
                    end else begin
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule
