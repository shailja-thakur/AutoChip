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
        B = 2'b01
    } state_t;

    state_t state, next_state;
    reg [1:0] count;

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (s)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (count == 2'b11)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // State and output registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            count <= 2'b00;
        end
        else begin
            state <= next_state;
            if (state == B) begin
                count <= count + w; // Add w to count
                if (count == 2'b10)
                    z <= 1'b1;
                else
                    z <= 1'b0;
            end
            else begin
                count <= 2'b00;
                z <= 1'b0;
            end
        end
    end
endmodule
