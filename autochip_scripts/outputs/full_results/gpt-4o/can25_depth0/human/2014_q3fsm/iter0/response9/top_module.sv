module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        STATE_A = 2'b00,
        STATE_B = 2'b01,
        STATE_C = 2'b10
    } state_t;
    
    state_t current_state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            STATE_A: begin
                if (s) begin
                    next_state = STATE_B;
                    z = 1'b0;
                end else begin
                    next_state = STATE_A;
                    z = 1'b0;
                end
            end
            STATE_B: begin
                if (cycle_count == 2'b11) begin
                    if (w_count == 2'b10) begin
                        z = 1'b1;
                    end else begin
                        z = 1'b0;
                    end
                    cycle_count = 2'b00;
                    w_count = 2'b00;
                end
                next_state = STATE_B;
            end
            default: next_state = STATE_A;
        endcase
    end

    // Counting logic for w and cycles
    always @(posedge clk) begin
        if (reset || current_state == STATE_A) begin
            w_count <= 2'b00;
            cycle_count <= 2'b00;
        end else if (current_state == STATE_B) begin
            cycle_count <= cycle_count + 1;
            if (w) begin
                w_count <= w_count + 1;
            end
        end
    end

endmodule
