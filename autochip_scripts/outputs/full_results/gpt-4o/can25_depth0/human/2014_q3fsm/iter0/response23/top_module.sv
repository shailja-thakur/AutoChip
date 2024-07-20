module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // States declaration
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next_state;
    reg [1:0] count;

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            count <= 2'b00;
        end else begin
            state <= next_state;

            if (state == B) begin
                count <= count + w;  // Increment count if w == 1
            end else begin
                count <= 2'b00;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (s == 1)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (count == 2)
                    next_state = C;
                else if (count == 3 || count == 4)
                    next_state = D;
                else
                    next_state = B;
            end
            C: begin
                next_state = B;
            end
            D: begin
                next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            z <= 0;
        end else if (state == C) begin
            z <= 1;
        end else begin
            z <= 0;
        end
    end

endmodule
