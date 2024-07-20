module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B1 = 3'b001,
        B2 = 3'b010,
        B3 = 3'b011,
        CHECK = 3'b100
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;

    // State transition: Synchronous process
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == B1 || state == B2 || state == B3) begin
                if (w) begin
                    w_count <= w_count + 1'b1;
                end
            end
            else if (state == CHECK) begin
                if (w_count == 2'b10) begin
                    z <= 1'b1;
                end else begin
                    z <= 1'b0;
                end
                w_count <= 2'b00;
            end
            else begin
                z <= 1'b0;
                w_count <= 2'b00;
            end
        end
    end

    // Next state logic: Combinational process
    always_comb begin
        next_state = state;
        case(state)
            A: begin
                if (s == 1'b1) begin
                    next_state = B1;
                end
            end

            B1: begin
                next_state = B2;
            end

            B2: begin
                next_state = B3;
            end

            B3: begin
                next_state = CHECK;
            end

            CHECK: begin
                next_state = B1;
            end

            default: next_state = A;
        endcase
    end

endmodule
