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
        C = 2'b10
    } state_t;

    state_t state, next_state;

    reg [1:0] w_count;
    reg [1:0] cycle_count;

    // State update
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            cycle_count <= 0;
        end else begin
            state <= next_state;
            if (state == B && cycle_count < 3) begin
                cycle_count <= cycle_count + 1;
                if (w) w_count <= w_count + 1;
            end else if (state == B && cycle_count == 3) begin
                cycle_count <= 0;
                w_count <= 0;
            end
        end
    end

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                if (cycle_count == 3) next_state = A;
                else next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            z <= 0;
        end else if (state == B && cycle_count == 3) begin
            if (w_count == 2) z <= 1;
            else z <= 0;
        end else begin
            z <= 0;
        end
    end

endmodule
