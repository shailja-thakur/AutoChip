module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        SHIFT = 3'b001,
        COUNT = 3'b010,
        DONE = 3'b011
    } state_t;
    
    state_t state, next_state;
    reg [3:0] pattern;
    reg [1:0] shift_count;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0000;
            shift_count <= 2'b00;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    pattern <= {pattern[2:0], data};
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                SHIFT: begin
                    shift_ena <= 1'b1;
                    shift_count <= shift_count + 1'b1;
                end
                COUNT: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b1;
                end
                DONE: begin
                    done <= 1'b1;
                end
            endcase
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (pattern == 4'b1101) next_state = SHIFT;
            end
            SHIFT: begin
                if (shift_count == 2'b11) next_state = COUNT;
                else next_state = SHIFT;
            end
            COUNT: begin
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                if (ack) next_state = IDLE;
            end
        endcase
    end

endmodule
