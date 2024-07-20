module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // FSM states
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        START = 2'b01,
        DATA = 2'b10,
        STOP = 2'b11
    } state_t;

    state_t state, next_state;
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
            
            // Output and internal registers update
            case (state)
                IDLE: begin
                    done <= 1'b0;
                end
                START: begin
                    if (in == 1'b0) begin
                        bit_cnt <= 3'b0; // Initialize bit counter
                    end
                end
                DATA: begin
                    shift_reg[bit_cnt] <= in;
                    bit_cnt <= bit_cnt + 1;
                    done <= 1'b0;
                end
                STOP: begin
                    if (in == 1'b1) begin // Stop bit should be 1
                        out_byte <= shift_reg;
                        done <= 1'b1;
                    end else begin
                        done <= 1'b0;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            IDLE: 
                next_state = (in == 1'b0) ? START : IDLE;
            START: 
                next_state = (in == 1'b0) ? DATA : IDLE;
            DATA: 
                next_state = (bit_cnt == 3'd7) ? STOP : DATA;
            STOP: 
                next_state = (in == 1'b1) ? IDLE : IDLE;
            default: 
                next_state = IDLE;
        endcase
    end

endmodule
