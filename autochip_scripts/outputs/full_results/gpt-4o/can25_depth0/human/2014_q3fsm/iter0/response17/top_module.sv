module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [1:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D
    } state_t;

    state_t state, next_state;
    reg [1:0] count;

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= STATE_A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
                else
                    next_state = STATE_A;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                next_state = STATE_D;
            end
            STATE_D: begin
                next_state = STATE_B;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Output Logic and count management
    always @(posedge clk) begin
        if (reset) begin
            count <= 2'b00;
            z <= 0;
        end else begin
            case (state)
                STATE_A: begin
                    count <= 2'b00;
                    z <= 0;
                end
                STATE_B: begin
                    count <= w ? count + 1 : count;
                end
                STATE_C: begin
                    count <= w ? count + 1 : count;
                end
                STATE_D: begin
                    count <= w ? count + 1 : count;
                    z <= (count == 2'b01 && w) ? 1 : (count == 2'b10 && !w) ? 1 : 0;
                end
                default: begin
                    count <= 2'b00;
                    z <= 0;
                end
            endcase
        end
    end

endmodule
