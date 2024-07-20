module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count; // Counter for 'w', we need exactly 2 w=1s in 3 cycles

    // State Transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            A: begin
                z = 1'b0;
                if (s) begin
                    next_state = B;
                end
            end
            B: begin
                z = 1'b0;
                next_state = C;
                w_count = 2'b00; // Reset w counter when entering state B
            end
            C: begin
                {z, w_count} = (w == 1'b1) ? {z, w_count + 1'b1} : {z, w_count}; // Count when w == 1
                if (w_count == 2'b11) begin // If 3 cycles have passed
                    if (w_count == 2'b10) begin
                        z = 1'b1; // If 'w' was high exactly 2 times in the last 3 clock cycles
                    end
                    next_state = D;
                end
            end
            D: begin
                z = 1'b0;
                if (w_count < 2'b10) begin
                    z = 1'b0;
                end
                next_state = B;
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

endmodule
