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
        CHECK_1 = 2'b10,
        CHECK_2 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] counter;
    reg [1:0] ones_count;

    // Sequential logic to handle state transitions and counter updates
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            counter <= 0;
            ones_count <= 0;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == CHECK_1 || state == CHECK_2) begin
                if (counter == 2) begin
                    z <= (ones_count == 2) ? 1 : 0;
                    counter <= 0;
                    ones_count <= 0;
                end else begin
                    counter <= counter + 1;
                    if (w == 1)
                        ones_count <= ones_count + 1;
                end
            end else begin
                counter <= 0;
                ones_count <= 0;
                z <= 0;
            end
        end
    end

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: begin
                if (s == 1)
                    next_state = B;
                else
                    next_state = A;
            end
            B: next_state = CHECK_1;
            CHECK_1: begin
                if (counter == 2)
                    next_state = CHECK_2;
                else
                    next_state = CHECK_1;
            end
            CHECK_2: begin
                if (counter == 2)
                    next_state = CHECK_1;
                else
                    next_state = CHECK_2;
            end
            default: next_state = A;
        endcase
    end

endmodule
