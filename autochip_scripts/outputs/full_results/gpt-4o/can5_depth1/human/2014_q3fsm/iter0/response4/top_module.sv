module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;
    logic [1:0] w_count; // Counter for the number of w=1 in the last three clock cycles

    // State transition (sequential logic)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == B || state == C) begin
                if (w) w_count <= w_count + 2'b01;
                else w_count <= w_count;
            end
            else
                w_count <= 2'b00;
                
            if (state == D) begin
                if (w_count == 2'b10) z <= 1'b1;
                else z <= 1'b0;
            end
            else
                z <= 1'b0;
        end
    end

    // Next state logic (combinational logic)
    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                next_state = C;
            end
            C: begin
                next_state = D;
            end
            D: begin
                next_state = B;
            end
            default: next_state = A;
        endcase
    end

endmodule
