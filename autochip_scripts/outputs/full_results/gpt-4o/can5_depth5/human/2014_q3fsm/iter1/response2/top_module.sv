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
        C = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg [1:0] count;
    reg [1:0] w_count;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            count <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_ff @(posedge clk) begin
        if (reset) begin
            next_state = A;
            z = 1'b0;
            count = 2'b00;
            w_count = 2'b00;
        end
        else begin
            case(state)
                A: begin
                    if (s == 1'b1)
                        next_state = B;
                    else
                        next_state = A;
                    z = 1'b0;
                end
                B: begin
                    if (count == 2'b10) begin
                        z = (w_count == 2'b10);
                        count = 2'b00;
                        w_count = 2'b00;
                    end
                    else
                        z = 1'b0;

                    count = count + 1;
                    if (w == 1'b1)
                        w_count = w_count + 1;

                    next_state = B;
                end
                default: next_state = A;
            endcase
        end
    end

endmodule
