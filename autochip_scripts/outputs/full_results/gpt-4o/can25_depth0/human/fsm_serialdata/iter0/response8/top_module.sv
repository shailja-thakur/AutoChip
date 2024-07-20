module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE   = 3'd0,
        START  = 3'd1,
        DATA   = 3'd2,
        STOP   = 3'd3,
        ERROR  = 3'd4
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_cnt;
    reg [7:0] shift_reg;
    
    // State transition and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 3'd0;
            shift_reg <= 8'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    if (in == 1'b0) begin // Start bit detected
                        next_state <= START;
                    end
                end
                START: begin
                    next_state <= DATA;
                    bit_cnt <= 3'd0;
                end
                DATA: begin
                    shift_reg[bit_cnt] <= in;
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 3'd7) begin
                        next_state <= STOP;
                    end
                end
                STOP: begin
                    if (in == 1'b1) begin // Stop bit verified
                        out_byte <= shift_reg;
                        done <= 1'b1;
                        next_state <= IDLE;
                    end else begin
                        next_state <= ERROR;
                    end
                end
                ERROR: begin
                    if (in == 1'b1) begin // Waiting for line to go idle
                        next_state <= IDLE;
                    end
                end
                default: begin
                    next_state <= IDLE;
                end
            endcase
        end
    end
    
    // Next state logic
    always_comb begin
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end else begin
                    next_state = IDLE;
                end
            end
            START: begin
                next_state = DATA;
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
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
    
endmodule
