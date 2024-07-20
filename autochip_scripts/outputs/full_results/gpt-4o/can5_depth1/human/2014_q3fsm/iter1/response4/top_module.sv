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
    reg [1:0] w_count; // Counter for the number of w=1 in the last three clock cycles

    // State transition (sequential logic)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == B1 || state == B2 || state == B3) begin
                w_count <= w_count + (w ? 1 : 0);
            end
            if (state == CHECK) begin
                z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                w_count <= 2'b00;
            end
        end
    end

    // Next state logic (combinational logic)
    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B1;
                else next_state = A;
            end
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = CHECK;
            CHECK: next_state = s ? B1 : A;
            default: next_state = A;
        endcase
    end
endmodule
