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
    reg [1:0] w_count;
    reg [1:0] sample_count;

    // State transition: Synchronous process
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            sample_count <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    // Combinational logic to control `w_count`, `sample_count`, and `z`
    always_ff @(posedge clk) begin
        if (state == B) begin
            sample_count <= sample_count + 1'b1;
            if (w) w_count <= w_count + 1'b1;

            if (sample_count == 2'b10) begin
                if (w_count == 2'b10) z <= 1'b1;
                else z <= 1'b0;
                w_count <= 2'b00;
                sample_count <= 2'b00;
            end
            else begin
                z <= 1'b0;
            end
        end
        else begin
            z <= 1'b0;
            w_count <= 2'b00;
            sample_count <= 2'b00;
        end
    end

    // Next state logic: Combinational process
    always_comb begin
        next_state = state;
        case(state)
            A: begin
                if (s == 1'b1) begin
                    next_state = B;
                end
            end

            B: begin
                if (sample_count == 2'b10) begin
                    next_state = B;
                end else begin
                    next_state = B;
                end
            end

            default: next_state = A;
        endcase
    end

endmodule
