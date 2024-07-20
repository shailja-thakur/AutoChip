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
        STATE_C = 2'b10,
        STATE_D = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Counter for 'w' values
    reg [1:0] w_counter;
    reg [1:0] cycle_counter;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= STATE_A;
        end else begin
            current_state <= next_state;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            w_counter <= 2'b00;
            cycle_counter <= 2'b00;
        end else begin
            if (current_state == STATE_B) begin
                cycle_counter <= cycle_counter + 1;
                if (w)
                    w_counter <= w_counter + 1;
            end else begin
                cycle_counter <= 2'b00;
                w_counter <= 2'b00;
            end
        end
    end

    always @* begin
        next_state = current_state;
        z = 1'b0;
        case (current_state)
            STATE_A: begin
                if (s)
                    next_state = STATE_B;
            end 
            STATE_B: begin
                if (cycle_counter == 2'b11) begin
                    if (w_counter == 2'b10)
                        z = 1'b1;
                    next_state = STATE_A;
                end
            end
        endcase
    end
endmodule
